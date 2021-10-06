#!/usr/bin/env bash
# from https://bbs.archlinux.org/viewtopic.php?id=235724
set -eu
org=localhost-ca
domain=localhost
caname=web-camera-ca

sudo trust anchor --remove $caname.crt || true

openssl genpkey -algorithm RSA -out $caname.key
openssl req -x509 -key $caname.key -out $caname.crt \
    -subj "/CN=$org/O=$org"

openssl genpkey -algorithm RSA -out "$domain".key
openssl req -new -key "$domain".key -out "$domain".csr \
    -subj "/CN=$domain/O=$org"

openssl x509 -req -in "$domain".csr -days 365 -out "$domain".crt \
    -CA $caname.crt -CAkey $caname.key -CAcreateserial \
    -extfile <(cat <<END
basicConstraints = CA:FALSE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
subjectAltName = DNS:$domain
END
    )

sudo trust anchor $caname.crt