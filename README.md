# KDF Interoperability Issue between OpenSSL and Python Libraries

## Problem Description

While working on a project, I discovered a lack of interoperability in the KDF (Key Derivation Function) results between the OpenSSL CLI tool and the Python libraries: `pycryptodome` and `Crypto.Protocol.KDF`.

I am unable to pinpoint the exact cause of the problem, but my primary suspect is OpenSSL, possibly related to differences in parameter processing.

## Environment Configuration

*   **Operating System:** Ubuntu 24.04 (running in Docker)
*   **OpenSSL:** 3.0.13 30 Jan 2024 (Library: OpenSSL 3.0.13 30 Jan 2024)
*   **Python Environment:** Defined in `Dockerfile` (includes `pycryptodome` and `cryptography`)

## Steps to Reproduce

```bash
cd ./bash
bash ./kdf.sh
cd ./../python
bash ./run.sh
cd ./../pyton-cryptodome
bash ./run.sh
cd ..
```

Found 07.06.2025
Mateusz Okulanis
FPGArtktic@outlook.com
