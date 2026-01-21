import socket
import threading
import json
import time

from crypto_utils import (
    generate_rsa_keypair, rsa_sign, rsa_verify,
    generate_nonce, serialize_key, deserialize_key
)
# ---------------------------------------------------------
# Client Module for Secure Chat Application
# ---------------------------------------------------------
class RelayServer:
    def __init__(self, host='localhost', port=5050):
        self.host = host
        self.port = port
        self.server_socket = None

        # client_id → {pub_key, socket, authenticated, nonce}
        self.clients = {}

        # For queued DH messages / normal messages
        self.pending_messages = {}

        # RSA keys for relay
        self.private_key, self.public_key = generate_rsa_keypair(2048)

        self.lock = threading.Lock()
        print("[RELAY] RSA keys generated.")

    # ---------------------------------------------------------
    # JSON HELPERS
    # ---------------------------------------------------------

    def send_json(self, sock, obj):
        try:
            msg = json.dumps(obj) + "\n"
            sock.sendall(msg.encode())
        except Exception as e:
            print(f"[RELAY] Send error: {e}")

    def recv_json(self, sock):
        buffer = b""
        try:
            while True:
                chunk = sock.recv(2048)
                if not chunk:
                    return None
                buffer += chunk
                if b"\n" in buffer:
                    line, buffer = buffer.split(b"\n", 1)
                    return json.loads(line.decode())
        except:
            return None

    # ---------------------------------------------------------
    # START SERVER
    # ---------------------------------------------------------

    def start(self):
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server_socket.bind((self.host, self.port))
        self.server_socket.listen(5)

        print(f"[RELAY] Server running on {self.host}:{self.port}")

        while True:
            sock, addr = self.server_socket.accept()
            print(f"[RELAY] New connection from {addr}")

            thread = threading.Thread(target=self.handle_client, args=(sock,))
            thread.daemon = True
            thread.start()

    # ---------------------------------------------------------
    # HANDLE CLIENT
    # ---------------------------------------------------------

    def handle_client(self, sock):
        client_id = None

        try:
            # EXPECT: register → auth_challenge → auth_response → ready

            # Step 1 — Registration
            msg = self.recv_json(sock)
            if msg and msg.get("type") == "register":
                ok, client_id = self.handle_register(sock, msg)
                if not ok:
                    return
            else:
                return

            # Step 2 — Auth Challenge
            msg = self.recv_json(sock)
            if msg and msg.get("type") == "auth_challenge":
                self.handle_auth_challenge(sock, msg)
            else:
                return

            # Step 3 — Auth Response
            msg = self.recv_json(sock)
            if msg and msg.get("type") == "auth_response":
                ok = self.handle_auth_response(sock, msg)
                if not ok:
                    return
            else:
                return

            # Mark authenticated
            with self.lock:
                self.clients[client_id]['authenticated'] = True

            print(f"[RELAY] {client_id} authenticated.")

            # ---------------------------------------------------------
            # MESSAGE LOOP
            # ---------------------------------------------------------
            while True:
                msg = self.recv_json(sock)
                if not msg:
                    break

                mtype = msg.get("type")

                if mtype == "dh_init":
                    self.handle_dh_init(msg)

                elif mtype == "dh_response":
                    self.handle_dh_response(msg)

                elif mtype == "send":
                    self.handle_send(sock, msg)

                elif mtype == "end_session":
                    self.handle_end_session(msg)

        except Exception as e:
            print(f"[RELAY] Error handling {client_id}: {e}")

        finally:
            with self.lock:
                if client_id in self.clients:
                    del self.clients[client_id]
            sock.close()
            print(f"[RELAY] {client_id} disconnected.")

    # ---------------------------------------------------------
    # REGISTRATION
    # ---------------------------------------------------------

    def handle_register(self, sock, msg):
        try:
            cid = msg["client_id"]
            pub_str = msg["pub_key"]
            signature = bytes.fromhex(msg["signature"])

            pub_key = deserialize_key(pub_str)

            reg_data = f"{cid}{pub_str}".encode()

            if not rsa_verify(pub_key, reg_data, signature):
                self.send_json(sock, {"status": "failed", "reason": "Invalid signature"})
                return False, None

            with self.lock:
                self.clients[cid] = {
                    "pub_key": pub_key,
                    "socket": sock,
                    "authenticated": False,
                    "nonce": None,
                    "dh_waiting": None,
                }
                self.pending_messages[cid] = []

            self.send_json(sock, {"status": "success"})
            print(f"[RELAY] Registered {cid}")
            return True, cid

        except Exception as e:
            print(f"[RELAY] Registration error: {e}")
            self.send_json(sock, {"status": "failed"})
            return False, None

    # ---------------------------------------------------------
    # AUTH CHALLENGE
    # ---------------------------------------------------------

    def handle_auth_challenge(self, sock, msg):
        try:
            cid = msg["client_id"]
            client_nonce = bytes.fromhex(msg["nonce"])

            server_nonce = generate_nonce()
            challenge_data = client_nonce + server_nonce

            signature = rsa_sign(self.private_key, challenge_data)

            with self.lock:
                self.clients[cid]["nonce"] = server_nonce

            reply = {
                "type": "auth_challenge_response",
                "server_nonce": server_nonce.hex(),
                "signature": signature.hex(),
                "pub_key": serialize_key(self.public_key)
            }
            self.send_json(sock, reply)

            print(f"[RELAY] Sent auth challenge to {cid}")

        except Exception as e:
            print(f"[RELAY] Auth challenge error: {e}")

    # ---------------------------------------------------------
    # AUTH RESPONSE
    # ---------------------------------------------------------

    def handle_auth_response(self, sock, msg):
        try:
            cid = msg["client_id"]
            signature = bytes.fromhex(msg["signature"])

            with self.lock:
                pub = self.clients[cid]["pub_key"]
                server_nonce = self.clients[cid]["nonce"]

            if not rsa_verify(pub, server_nonce, signature):
                self.send_json(sock, {"status": "failed"})
                print(f"[RELAY] Auth failed for {cid}")
                return False

            self.send_json(sock, {"status": "success"})
            print(f"[RELAY] Authentication OK for {cid}")
            return True

        except:
            return False

    # ---------------------------------------------------------
    # DIFFIE–HELLMAN FORWARDING
    # ---------------------------------------------------------

    def handle_dh_init(self, msg):
        """
        A → Relay → B : g^a
        """
        sender = msg["sender_id"]
        peer = msg["peer_id"]
        g_a = msg["g_a"]

        print(f"[RELAY] DH_INIT from {sender} to {peer}")

        with self.lock:
            if peer not in self.clients:
                return

            sock = self.clients[peer]["socket"]

        forward = {
            "type": "dh_forward_init",
            "sender_id": sender,
            "g_a": g_a
        }
        self.send_json(sock, forward)

    def handle_dh_response(self, msg):
        """
        B → Relay → A : g^b
        """
        sender = msg["sender_id"]
        peer = msg["peer_id"]
        g_b = msg["g_b"]

        print(f"[RELAY] DH_RESPONSE from {sender} to {peer}")

        with self.lock:
            if peer not in self.clients:
                return

            sock = self.clients[peer]["socket"]

        forward = {
            "type": "dh_forward_response",
            "sender_id": sender,
            "g_b": g_b
        }
        self.send_json(sock, forward)

    # ---------------------------------------------------------
    # FORWARD SECURE MESSAGES
    # ---------------------------------------------------------

    def handle_send(self, sock, msg):
        """
        Forward ciphertext from A → B.
        Relay does NOT decrypt anything.
        """
        sender = msg["sender_id"]
        receiver = msg["receiver_id"]

        message_out = {
            "type": "message",
            "sender_id": sender,
            "ciphertext": msg["ciphertext"],
            "seq_num": msg["seq_num"],
            "timestamp": msg["timestamp"],
            "tag": msg["tag"]
        }

        # ACK sender
        self.send_json(sock, {"status": "success"})

        with self.lock:
            if receiver in self.clients and self.clients[receiver]["authenticated"]:
                self.send_json(self.clients[receiver]["socket"], message_out)
            else:
                # queue
                self.pending_messages[receiver].append(message_out)

    # ---------------------------------------------------------
    # END SESSION
    # ---------------------------------------------------------

    def handle_end_session(self, msg):
        print(f"[RELAY] Session end received for {msg['session_id']}")

        peer = msg["peer_id"]
        sender = msg["sender_id"]

        with self.lock:
            if peer in self.clients:
                self.send_json(self.clients[peer]["socket"], msg)


if __name__ == "__main__":
    relay = RelayServer()
    relay.start()