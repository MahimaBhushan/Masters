import hashlib
import hmac
from Crypto.PublicKey import RSA
from Crypto.Hash import SHA256
from Crypto.Signature import pss
import os

# ---------------------------------------------------------
# 2048-bit Diffie–Hellman safe prime (RFC 3526 Group 14)
# ---------------------------------------------------------
DH_P = int(
    "FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E08"
    "8A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD"
    "3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6"
    "F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F241"
    "17C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D3"
    "9A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED52"
    "2625F78E2BF1EBE3CDC56D9E7C2F180C7", 16
)

DH_G = 2  # generator


# ---------------------------------------------------------
# HASH FUNCTIONS
# ---------------------------------------------------------

def sha256(data):
    """Hash using SHA-256."""
    if isinstance(data, str):
        data = data.encode()
    return hashlib.sha256(data).digest()


def sha1(data):
    """Hash using SHA-1."""
    if isinstance(data, str):
        data = data.encode()
    return hashlib.sha1(data).digest()


# ---------------------------------------------------------
# HMAC
# ---------------------------------------------------------

def hmac_sign(key, data):
    """Compute HMAC-SHA256."""
    if isinstance(key, str):
        key = key.encode()
    if isinstance(data, str):
        data = data.encode()
    return hmac.new(key, data, hashlib.sha256).digest()


def hmac_verify(key, data, tag):
    """Verify HMAC-SHA256."""
    expected = hmac_sign(key, data)
    return hmac.compare_digest(expected, tag)


# ---------------------------------------------------------
# RSA SIGNING & VERIFICATION
# ---------------------------------------------------------

def generate_rsa_keypair(bits=2048):
    """Generate RSA private/public key pair."""
    key = RSA.generate(bits)
    return key, key.publickey()


def rsa_sign(private_key, data):
    """Sign data using RSA-PSS + SHA256."""
    if isinstance(data, str):
        data = data.encode()
    h = SHA256.new(data)
    signer = pss.new(private_key)
    return signer.sign(h)


def rsa_verify(public_key, data, signature):
    """Verify RSA signature."""
    if isinstance(data, str):
        data = data.encode()
    h = SHA256.new(data)
    verifier = pss.new(public_key)
    try:
        verifier.verify(h, signature)
        return True
    except ValueError:
        return False


# ---------------------------------------------------------
# NONCES
# ---------------------------------------------------------

def generate_nonce(length=16):
    return os.urandom(length)


# ---------------------------------------------------------
# XOR STREAM ENCRYPTION
# ---------------------------------------------------------

def xor_encrypt(data, keystream):
    """XOR bytes."""
    if isinstance(data, str):
        data = data.encode()
    return bytes(a ^ b for a, b in zip(data, keystream))


# ---------------------------------------------------------
# STREAM KEY DERIVATION (SHA1-based)
# ---------------------------------------------------------

def derive_keystream(session_key, seq_num, timestamp, length):
    """
    Derive keystream using repeated SHA-1 hashing.
    Input = K || seq || timestamp || counter
    """
    if isinstance(session_key, str):
        session_key = session_key.encode()

    keystream = b""
    counter = 0

    # using SHA-1 to generate keystream blocks
    # Using SHA-1 for better performance
    while len(keystream) < length:
        block = (
            session_key +
            seq_num.to_bytes(8, 'big') +
            timestamp.to_bytes(8, 'big') +
            counter.to_bytes(4, 'big')
        )
        keystream += sha1(block)
        counter += 1

    return keystream[:length]


# ---------------------------------------------------------
# DIFFIE–HELLMAN FUNCTIONS
# ---------------------------------------------------------

def dh_generate_private():
    """Generate DH private exponent (256-bit random)."""
    return int.from_bytes(os.urandom(32), 'big')


def dh_generate_public(a):
    """Compute g^a mod p."""
    return pow(DH_G, a, DH_P)


def dh_compute_shared(B, a):
    """Compute shared secret = B^a mod p."""
    return pow(B, a, DH_P)


# ---------------------------------------------------------
# KEY SERIALIZATION
# ---------------------------------------------------------

def serialize_key(key):
    return key.exportKey().decode()


def deserialize_key(key_str):
    return RSA.import_key(key_str.encode())
