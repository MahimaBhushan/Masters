import socket
import json
import threading
import time
import sys

from crypto_utils import (
    generate_rsa_keypair, rsa_sign, rsa_verify, generate_nonce,
    serialize_key, deserialize_key,
    dh_generate_private, dh_generate_public, dh_compute_shared,
    sha256, derive_keystream, xor_encrypt,
    hmac_sign, hmac_verify
)

# ---------------------------------------------------------
# Client Module for Secure Chat Application
# ---------------------------------------------------------
class ChatClient:
    def __init__(self, client_id, relay_host='localhost', relay_port=5050):
        self.client_id = client_id
        self.relay_host = relay_host
        self.relay_port = relay_port

        self.relay_socket = None
        self.relay_pub_key = None

        # local RSA keys
        self.private_key, self.public_key = generate_rsa_keypair(2048)

        # session info
        self.peer_id = None
        self.session_key = None
        self.session_id = None
        self.seq_num = 0
        self.last_seq_num = {}

        # DH state
        self.dh_private = None   # a
        self.dh_public = None    # g^a

        self.buffer = b""
        self.authenticated = False
        self.receiving = False

        print(f"[{self.client_id}] Client initialized.")

    # ---------------------------------------------------------
    # SOCKET HELPERS
    # ---------------------------------------------------------

    def send_json(self, obj):
        try:
            msg = json.dumps(obj) + "\n"
            self.relay_socket.sendall(msg.encode())
        except:
            print(f"[{self.client_id}] ERROR sending JSON")

    def recv_json(self):
        try:
            while True:
                chunk = self.relay_socket.recv(2048)
                if not chunk:
                    return None
                self.buffer += chunk
                if b"\n" in self.buffer:
                    line, self.buffer = self.buffer.split(b"\n", 1)
                    return json.loads(line.decode())
        except:
            return None

    # ---------------------------------------------------------
    # CONNECT
    # ---------------------------------------------------------

    def connect(self):
        # Use socket programming to connect to relay
        self.relay_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.relay_socket.connect((self.relay_host, self.relay_port))
        print(f"[{self.client_id}] Connected to relay.")

    # ---------------------------------------------------------
    # REGISTRATION
    # ---------------------------------------------------------

    def register(self):
        pub_str = serialize_key(self.public_key)
        data = f"{self.client_id}{pub_str}".encode()
        signature = rsa_sign(self.private_key, data)

        msg = {
            "type": "register",
            "client_id": self.client_id,
            "pub_key": pub_str,
            "signature": signature.hex()
        }
        self.send_json(msg)

        resp = self.recv_json()
        if resp and resp.get("status") == "success":
            print(f"[{self.client_id}] Registration OK.")
            return True
        else:
            print(f"[{self.client_id}] Registration FAILED.")
            return False

    # ---------------------------------------------------------
    # AUTHENTICATION
    # ---------------------------------------------------------

    def authenticate(self):
        try:
            # Step 1: send nonce to relay
            nonce_c = generate_nonce()
            self.send_json({
                "type": "auth_challenge",
                "client_id": self.client_id,
                "nonce": nonce_c.hex()
            })

            # Step 2: get relay challenge
            resp = self.recv_json()
            if not resp:
                print(f"[{self.client_id}] Auth failed: no response.")
                return False

            nonce_s = bytes.fromhex(resp["server_nonce"])
            sig = bytes.fromhex(resp["signature"])
            relay_pub = deserialize_key(resp["pub_key"])
            self.relay_pub_key = relay_pub

            challenge = nonce_c + nonce_s
            if not rsa_verify(relay_pub, challenge, sig):
                print(f"[{self.client_id}] Relay signature INVALID.")
                return False

            # Step 3: send proof to relay
            my_sig = rsa_sign(self.private_key, nonce_s)
            self.send_json({
                "type": "auth_response",
                "client_id": self.client_id,
                "signature": my_sig.hex()
            })

            # Step 4: final confirmation
            resp = self.recv_json()
            if resp and resp.get("status") == "success":
                self.authenticated = True
                print(f"[{self.client_id}] Authentication OK.")
                return True

            print(f"[{self.client_id}] Authentication FAILED.")
            return False

        except Exception as e:
            print(f"[{self.client_id}] Auth error: {e}")
            return False

    # ---------------------------------------------------------
    # DIFFIE–HELLMAN SESSION SETUP
    # ---------------------------------------------------------

    def setup_session(self, peer_id):
        self.peer_id = peer_id
        self.session_id = f"{self.client_id}-{peer_id}-{int(time.time())}"
        print(f"[{self.client_id}] Starting session setup with {peer_id}...")

        # Generate DH private & public values
        self.dh_private = dh_generate_private()
        self.dh_public = dh_generate_public(self.dh_private)

        print(f"[{self.client_id}] DH private exponent generated.")
        print(f"[{self.client_id}] Sending g^a to {peer_id}...")

        # Send DH_INIT to relay
        self.send_json({
            "type": "dh_init",
            "sender_id": self.client_id,
            "peer_id": peer_id,
            "g_a": hex(self.dh_public)
        })

        # Start receiving thread
        self.receiving = True
        threading.Thread(target=self.receive_loop, daemon=True).start()

    # Handle DH messages
    def handle_dh_init(self, msg):
        sender = msg["sender_id"]
        g_a = int(msg["g_a"], 16)

        print(f"[{self.client_id}] Received g^a from {sender}. Sending g^b...")

        # Generate DH private & public for this side
        self.dh_private = dh_generate_private()
        self.dh_public = dh_generate_public(self.dh_private)

        # Compute shared secret using generated dh private key
        shared = dh_compute_shared(g_a, self.dh_private)
        self.session_key = sha256(str(shared).encode())

        print(f"[{self.client_id}] Session key established with {sender}!")

        # Respond with g^b
        self.send_json({
            "type": "dh_response",
            "sender_id": self.client_id,
            "peer_id": sender,
            "g_b": hex(self.dh_public)
        })

    def handle_dh_response(self, msg):
        sender = msg["sender_id"]
        g_b = int(msg["g_b"], 16)

        print(f"[{self.client_id}] Received g^b from {sender}. Computing shared key...")

        shared = dh_compute_shared(g_b, self.dh_private)
        self.session_key = sha256(str(shared).encode())

        print(f"[{self.client_id}] Session key established! Secure chat is ON.")

    # ---------------------------------------------------------
    # SECURE MESSAGING
    # ---------------------------------------------------------

    def send_message(self, plaintext):
        if self.session_key is None:
            print(f"[{self.client_id}] No session key yet.")
            return

        self.seq_num += 1
        timestamp = int(time.time())

        # Derive keystream for XOR encryption with SHA derived keystream
        ks = derive_keystream(self.session_key, self.seq_num, timestamp, len(plaintext))

        ciphertext = xor_encrypt(plaintext, ks)

        tag_data = (
            ciphertext +
            self.seq_num.to_bytes(8, 'big') +
            timestamp.to_bytes(8, 'big') +
            self.client_id.encode() +
            self.peer_id.encode()
        )
        tag = hmac_sign(self.session_key, tag_data)

        msg = {
            "type": "send",
            "sender_id": self.client_id,
            "receiver_id": self.peer_id,
            "session_id": self.session_id,
            "ciphertext": ciphertext.hex(),
            "seq_num": self.seq_num,
            "timestamp": timestamp,
            "tag": tag.hex()
        }

        self.send_json(msg)
        resp = self.recv_json()
        if resp and resp.get("status") == "success":
            print(f"[{self.client_id}] Sent → {plaintext}")

    def handle_secure_message(self, msg):
        sender = msg["sender_id"]
        ciphertext = bytes.fromhex(msg["ciphertext"])
        seq = msg["seq_num"]
        timestamp = msg["timestamp"]
        tag = bytes.fromhex(msg["tag"])

        # Replay protection
        last = self.last_seq_num.get(sender, 0)
        if seq <= last:
            print(f"[{self.client_id}] Replay attack blocked!")
            return
        self.last_seq_num[sender] = seq

        # Verify HMAC
        tag_data = (
            ciphertext +
            seq.to_bytes(8, 'big') +
            timestamp.to_bytes(8, 'big') +
            sender.encode() +
            self.client_id.encode()
        )
        if not hmac_verify(self.session_key, tag_data, tag):
            print(f"[{self.client_id}] Message integrity FAIL!")
            return

        # Decrypt
        ks = derive_keystream(self.session_key, seq, timestamp, len(ciphertext))
        plaintext = xor_encrypt(ciphertext, ks)

        try:
            text = plaintext.decode()
        except:
            text = "<DECODE ERROR>"

        print(f"\n[{sender}] {text}")
        print(f"[{self.client_id}] > ", end="", flush=True)

    # ---------------------------------------------------------
    # RECEIVE LOOP
    # ---------------------------------------------------------

    def receive_loop(self):
        while self.receiving:
            msg = self.recv_json()
            if not msg:
                break

            t = msg.get("type")

            if t == "dh_forward_init":
                self.handle_dh_init(msg)

            elif t == "dh_forward_response":
                self.handle_dh_response(msg)

            elif t == "message":
                self.handle_secure_message(msg)

            elif t == "end_session":
                print(f"[{self.client_id}] Session ended by peer.")
                self.receiving = False

    # ---------------------------------------------------------
    # END SESSION
    # ---------------------------------------------------------

    def end_session(self):
        print(f"[{self.client_id}] Ending session with {self.peer_id}...")

        self.send_json({
            "type": "end_session",
            "session_id": self.session_id,
            "sender_id": self.client_id,
            "peer_id": self.peer_id,
        })

        self.receiving = False

    # ---------------------------------------------------------
    # CLOSE
    # ---------------------------------------------------------

    def close(self):
        if self.relay_socket:
            self.relay_socket.close()

# ---------------------------------------------------------
# MAIN
# ---------------------------------------------------------

def main():
    if len(sys.argv) < 2:
        print("Usage: python client.py <client_id>")
        return

    cid = sys.argv[1]
    client = ChatClient(cid)

    client.connect()
    client.register()
    client.authenticate()

    # Ask user which client to talk to
    peer = input(f"[{cid}] Enter peer client ID: ")
    client.setup_session(peer)

    print(f"[{cid}] Secure chat started. Type 'exit' to quit.")

    try:
        while True:
            msg = input(f"[{cid}] > ")
            if msg.lower() == "exit":
                break
            client.send_message(msg)
    except KeyboardInterrupt:
        print(f"\n[{cid}] Interrupted.")

    client.end_session()
    client.close()


if __name__ == "__main__":
    main()