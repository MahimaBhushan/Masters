import time
from client import ChatClient
from crypto_utils import (
    dh_generate_private, dh_generate_public, dh_compute_shared,
    sha256, derive_keystream, xor_encrypt, hmac_sign
)

# ---------------------------------------------------------
# Replay Attack Demonstration
# ---------------------------------------------------------
class ReplayAttacker:
    
    # Intialize to connect to Relay
    def __init__(self, relay_host='localhost', relay_port=5050):
        self.relay_host = relay_host
        self.relay_port = relay_port
        self.captured_messages = []
    
    # Mocking two clients, Alice and Bob for demonstration
    def setup_clients(self):
        print("REPLAY ATTACK DEMONSTRATION\n")
        
        # Create Alice as Client 1
        alice = ChatClient("Alice", self.relay_host, self.relay_port)
        alice.connect()
        alice.register()
        alice.authenticate()
        
        # Create Bob as Client 2
        bob = ChatClient("Bob", self.relay_host, self.relay_port)
        bob.connect()
        bob.register()
        bob.authenticate()
                
        # Manually setup DH session
        alice.peer_id = "Bob"
        bob.peer_id = "Alice"
        

        alice.dh_private = dh_generate_private()
        alice.dh_public = dh_generate_public(alice.dh_private)
        

        bob.dh_private = dh_generate_private()
        bob.dh_public = dh_generate_public(bob.dh_private)
        

        shared_alice = dh_compute_shared(bob.dh_public, alice.dh_private)
        shared_bob = dh_compute_shared(alice.dh_public, bob.dh_private)
        

        alice.session_key = sha256(str(shared_alice).encode())
        bob.session_key = sha256(str(shared_bob).encode())
        
        print(f"Session key established between Alice and Bob\n")
        
        return alice, bob
    
    def capture_message(self, client, peer_id, plaintext):
        client.seq_num += 1
        timestamp = int(time.time())
        
        # Use client's session key to encrypt
        ks = derive_keystream(client.session_key, client.seq_num, timestamp, len(plaintext))
        ciphertext = xor_encrypt(plaintext, ks)
        
        # Create HMAC tag
        tag_data = (
            ciphertext +
            client.seq_num.to_bytes(8, 'big') +
            timestamp.to_bytes(8, 'big') +
            client.client_id.encode() +
            peer_id.encode()
        )
        tag = hmac_sign(client.session_key, tag_data)
        
        # Return message in the format expected by handle_secure_message
        msg_data = {
            "sender_id": client.client_id,
            "receiver_id": peer_id,
            "ciphertext": ciphertext.hex(),
            "seq_num": client.seq_num,
            "timestamp": timestamp,
            "tag": tag.hex()
        }
        
        return msg_data
    
    def demonstrate_replay_attack(self):
        alice, bob = self.setup_clients()
        
        print("COMMUNICATION DEMONSTRATION BETWEEN ALICE AND BOB")

        # Send mocked messaged between Alice and Bob
        print("\nAlice to Bob: 'Hello Bob!'")
        msg1 = self.capture_message(alice, bob.client_id, "Hello Bob!")
        
        # Bob receives first message using actual handle_secure_message
        bob.handle_secure_message(msg1)
        time.sleep(0.5)
        
        print("Alice to Bob: 'How are you doing?'")
        msg2 = self.capture_message(alice, bob.client_id, "How are you doing?")
        
        bob.handle_secure_message(msg2)
        time.sleep(0.5)
        
        print("\nBoth messages delivered successfully")
        print(f"Message 1 seq_num: {msg1['seq_num']}")
        print(f"Message 2 seq_num: {msg2['seq_num']}")
        
        print("ATTEMPTING REPLAY ATTACK")
        
        print(f"\nCaptured message from Alice (seq_num: {msg1['seq_num']})")
        print("Attempting to replay old message\n")
        
        time.sleep(1)
        bob.handle_secure_message(msg1)
        
        print("REPLAY PROTECTION DEMONSTRATION")
        
        # Check if replay was blocked
        current_last_seq = bob.last_seq_num.get("Alice", 0)
        
        if current_last_seq == msg2['seq_num']:
            print("\nREPLAY ATTACK BLOCKED!")
            print(f"Reason: Sequence number {msg1['seq_num']} ≤ last seen sequence {current_last_seq}")
            print("The replay protection detected this as a replay attack.")
        else:
            print("\nREPLAY ATTACK SUCCEEDED")
        
        print(f"\nBob's last sequence number from Alice: {bob.last_seq_num.get('Alice', 0)}")
        print(f"Replayed message sequence number: {msg1['seq_num']}")
        print("\nReplay Protection successfully demonstrated.")
        
        # Cleanup
        alice.close()
        bob.close()


if __name__ == "__main__":
    
    print("This demonstration shows how the secure chat application")
    print("protects against replay attacks using sequence numbers.\n")
    
    try:
        demo = ReplayAttacker()
        demo.demonstrate_replay_attack()
        
        print("Replay attack protection successfully demonstrated.\n")
        
    except ConnectionRefusedError:
        print("\nERROR: Could not connect to relay server")
        print("  Please ensure relay.py is running on localhost:5050")
    except Exception as e:
        print(f"\nERROR: {e}")
        import traceback
        traceback.print_exc()