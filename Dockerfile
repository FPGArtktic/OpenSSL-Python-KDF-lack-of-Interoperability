# syntax=docker/dockerfile:1
FROM python:3.11-slim

WORKDIR /app

# Install openssl, hexdump and python cryptography library
RUN apt-get update && \
    apt-get install -y openssl bsdmainutils && \
    pip install --no-cache-dir cryptography && \
    pip install --no-cache-dir pycryptodome && \
    rm -rf /var/lib/apt/lists/*

# Wspólny obraz dla ECDH i KDF
# Ustaw ścieżkę do plików binarnych aby wersje openssl i Python były identyczne
ENV PATH="/usr/local/bin:${PATH}"

# Default command (can be overridden)
CMD ["echo", "Wybierz skrypt do uruchomienia (ecdh_cryptography.py lub kdf_reference.py)"]
