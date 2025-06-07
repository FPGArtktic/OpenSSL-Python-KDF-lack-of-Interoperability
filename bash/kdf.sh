rm -f *.bin *.hex
openssl rand 64 > salt.bin
hex=$(xxd -p salt.bin | tr -d '\n')
hexdump -C salt.bin > salt.hex
password_hex=$(echo -n "test_password" | xxd -p | tr -d '\n')
salt_hex=$(xxd -p salt.bin | tr -d '\n')
info_hmac_hex=$(echo -n "HMAC_encryption_key" | xxd -p | tr -d '\n')
info_aes_hex=$(echo -n "AES_encryption_key" | xxd -p | tr -d '\n')

echo "Password (hex input to openssl): $password_hex"
echo "Salt (hex input to openssl): $salt_hex"
echo "Info HMAC (hex input to openssl): $info_hmac_hex"
echo "Info AES (hex input to openssl): $info_aes_hex"

openssl kdf -keylen 64 -kdfopt digest:SHA3-512 -kdfopt key:$password_hex -kdfopt salt:$salt_hex -kdfopt info:$info_hmac_hex -kdfopt mode:EXTRACT_AND_EXPAND -binary HKDF > HMAC_derivated_key.bin
openssl kdf -keylen 32 -kdfopt digest:SHA3-512 -kdfopt key:$password_hex -kdfopt salt:$salt_hex -kdfopt info:$info_aes_hex -kdfopt mode:EXTRACT_AND_EXPAND -binary HKDF > AES_derivated_key.bin
hexdump -C HMAC_derivated_key.bin > HMAC_derivated_key.hex
hexdump -C AES_derivated_key.bin > AES_derivated_key.hex
