import time
from client import ChatClient
from crypto_utils import (
    dh_generate_private, dh_generate_public, dh_compute_shared,
    sha256, derive_keystream, xor_encrypt, hmac_sign
)

# ---------------------------------------------------------
# Tampering Attack Demonstration
# ---------------------------------------------------------
class TamperAttack:
    
    def __init__(self, relay_host='localhost', relay_port=5050):
        self.relay_host = relay_host
        self.relay_port = relay_port
        
    def setup_clients(self):

        print("MESSAGE TAMPERING DETECTION DEMONSTRATION")
        
        # Create Alice as client 1
        alice = ChatClient("Alice", self.relay_host, self.relay_port)
        alice.connect()
        alice.register()
        alice.authenticate()
        
        # Create Bob as Client 2
        bob = ChatClient("Bob", self.relay_host, self.relay_port)
        bob.connect()
        bob.register()
        bob.authenticate()
                
        # Manually setup DH session (simplified for demo)
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
    
    def create_message(self, client, peer_id, plaintext):
        # create a dummy message to simulate sending
        client.seq_num += 1
        timestamp = int(time.time())
        
        ks = derive_keystream(client.session_key, client.seq_num, timestamp, len(plaintext))
        ciphertext = xor_encrypt(plaintext, ks)
        
        tag_data = (
            ciphertext +
            client.seq_num.to_bytes(8, 'big') +
            timestamp.to_bytes(8, 'big') +
            client.client_id.encode() +
            peer_id.encode()
        )
        tag = hmac_sign(client.session_key, tag_data)
        
        msg_data = {
            "sender_id": client.client_id,
            "receiver_id": peer_id,
            "ciphertext": ciphertext.hex(),
            "seq_num": client.seq_num,
            "timestamp": timestamp,
            "tag": tag.hex()
        }
        
        return msg_data
    
    def tamper1(self, msg):
        # Try with tampering the ciphertext and check if it protects
        ciphertext_bytes = bytes.fromhex(msg["ciphertext"])
        
        tampered = bytearray(ciphertext_bytes)
        tamper_position = len(tampered) // 2
        tampered[tamper_position] ^= 0xFF  # Flip all bits in this byte
        
        tampered_msg = msg.copy()
        tampered_msg["ciphertext"] = tampered.hex()
        
        return tampered_msg
    
    def tamper2(self, msg):


        tampered_msg = msg.copy()
        tampered_msg["seq_num"] = msg["seq_num"] + 1000 
        return tampered_msg
    
    def tamper_timestamp(self, msg):

        tampered_msg = msg.copy()
        tampered_msg["timestamp"] = msg["timestamp"] + 3600  
        return tampered_msg
    
    def demonstrate_tampering_attacks(self):
       
        alice, bob = self.setup_clients()
        
        
        # Send legitimate message
        print("\nAlice to Bob: 'Hello Bob!'")
        legitimate_msg = self.create_message(alice, bob.client_id, "Hello Bob!")
        print(f"Message seq_num: {legitimate_msg['seq_num']}")
        print(f"HMAC tag: {legitimate_msg['tag'][:32]}...")
        
        # Bob receives legitimate message
        print("\n[Bob] Receiving legitimate message")
        bob.handle_secure_message(legitimate_msg)
        
        time.sleep(1)

        print("TAMPERING ATTACK: TAMPER CIPHERTEXT")

        
        print("\nAlice to Bob:'Meet me here'")
        original_msg = self.create_message(alice, bob.client_id, "Meet me here")
        print(f"  Original ciphertext: {original_msg['ciphertext'][:40]}...")
        
        print("\nIntercepting message and tampering with ciphertext...")
        tmsg1 = self.tamper1(original_msg)
        print(f"  Tampered ciphertext: {tmsg1['ciphertext'][:40]}...")
        print("  (Changed byte at position {})".format(len(bytes.fromhex(original_msg['ciphertext'])) // 2))
        
        print("\n[Bob] Receiving tampered message...")
        print("Verifying HMAC")
        bob.handle_secure_message(tmsg1)
        
        time.sleep(1)

        print("TAMPERING ATTACK: MODIFY SEQUENCE NUMBER")

        print("\nAlice to Bob Creating message: 'Execute order 66'")
        msg2 = self.create_message(alice, bob.client_id, "Execute order 66")
        print(f"  Original seq_num: {msg2['seq_num']}")
        
        print("\nTampering with sequence number...")
        tmsg2 = self.tamper2(msg2)
        print(f"  Tampered seq_num: {tmsg2['seq_num']}")
        print("  (HMAC tag remains unchanged)")
        
        print("\n[Bob] Receiving tampered message")
        print("Verifying HMAC with tampered seq_num")
        bob.handle_secure_message(tmsg2)
        
        time.sleep(1)
        

        print("TAMPERING ATTACK MODIFY TIMESTAMP")
        
        print("\nAlice to Bob Creating message: 'catch up at nearest cafe'")
        msg3 = self.create_message(alice, bob.client_id, "catch up at nearest cafe")
        print(f"  Original timestamp: {msg3['timestamp']}")

        tampered_msg3 = self.tamper_timestamp(msg3)
        print(f"  Tampered timestamp: {tampered_msg3['timestamp']}")
        print("  (Changed by +3600 seconds / +1 hour)")
        
        print("\n[Bob] Receiving tampered message...")
        print("Verifying HMAC with tampered timestamp...")
        bob.handle_secure_message(tampered_msg3)
        
        time.sleep(1)
        
        print("\nIntegrity Protection successfully demonstrated.")
        
        alice.close()
        bob.close()


if __name__ == "__main__":
    
    try:
        demo = TamperAttack()
        demo.demonstrate_tampering_attacks()
        
    except ConnectionRefusedError:
        print("\nERROR: Could not connect to relay server")
        print("Please ensure relay.py is running on localhost:5050")
    except Exception as e:
        print(f"\n✗ ERROR: {e}")
        import traceback
        traceback.print_exc()