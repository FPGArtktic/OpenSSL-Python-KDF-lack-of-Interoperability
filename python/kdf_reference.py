import os
from Crypto.Protocol.KDF import HKDF
from Crypto.Hash import SHA3_512

# Load salt from a binary file
def load_salt(path):
    with open(path, "rb") as f:
        return f.read()

def derive_key(password: bytes, salt: bytes, info: bytes, keylen: int, digestmod=SHA3_512):
    # PyCryptodome HKDF expects password as the 'master' key
    return HKDF(
        master=password,
        key_len=keylen,
        salt=salt,
        hashmod=digestmod,
        num_keys=1,
        context=info
    )

def main():
    # Parameters
    password = b"test_password"
    salt = load_salt("./salt.bin")
    # Dynamically generate info (as in bash)
    info_hmac_str = "HMAC_encryption_key"
    info_aes_str = "AES_encryption_key"
    # Important: pass info as HEX, just like in bash
    info_hmac = bytes.fromhex(info_hmac_str.encode("utf-8").hex())
    info_aes = bytes.fromhex(info_aes_str.encode("utf-8").hex())
    # Debugging output
    print("Password (hex):", password.hex())
    print("Salt (hex):", salt.hex())
    print("Info HMAC (hex):", info_hmac.hex())
    print("Info AES (hex):", info_aes.hex())
    # Derive HMAC key (64 bytes)
    hmac_key = derive_key(password, salt, info_hmac, 64)
    with open("HMAC_derivated_key.bin", "wb") as f:
        f.write(hmac_key)
    # Derive AES key (32 bytes)
    aes_key = derive_key(password, salt, info_aes, 32)
    with open("AES_derivated_key.bin", "wb") as f:
        f.write(aes_key)
    print("HMAC and AES keys generated in binary form.")

if __name__ == "__main__":
    main()
