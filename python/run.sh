#!/bin/bash
# Script to run KDF in Docker container
rm -f *.bin *.hex
cd "$(dirname "$0")"
cp ../bash/salt.bin .
docker build -f ../Dockerfile -t crypt_hazmat ../..
docker run --rm -v $(pwd):/app crypt_hazmat python kdf_reference.py
hexdump -C HMAC_derivated_key.bin > HMAC_derivated_key.hex
hexdump -C AES_derivated_key.bin > AES_derivated_key.hex

# Compare results between bash and python
echo "KDF results comparison:"
echo "HMAC:"
if cmp -s ../bash/HMAC_derivated_key.bin HMAC_derivated_key.bin; then
    echo "HMAC files are identical! ✓"
else
    echo "HMAC files are different ✗"
    echo "Differences (hexdump):"
    diff -y <(xxd ../bash/HMAC_derivated_key.bin) <(xxd HMAC_derivated_key.bin) | head -10
fi

echo "AES:"
if cmp -s ../bash/AES_derivated_key.bin AES_derivated_key.bin; then
    echo "AES files are identical! ✓"
else
    echo "AES files are different ✗"
    echo "Differences (hexdump):"
    diff -y <(xxd ../bash/AES_derivated_key.bin) <(xxd AES_derivated_key.bin) | head -10
fi