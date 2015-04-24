#!/bin/bash

if [[ -z "$1" ]] ; then
    echo "Usage: $0 <cert name>"
    exit 1
fi

if [[ ! -e "${1}.key" ]] ; then
    echo "No key file ${1}.key found"
    exit 2
fi

if [[ ! -e "${1}.crt" ]] ; then
    echo "No cert file ${1}.crt found"
    exit 3
fi

keymodulus=$( openssl rsa -in "${1}.key" -noout -modulus )
crtmodulus=$( openssl x509 -in "${1}.crt" -noout -modulus )

if [[ "${keymodulus}" != "${crtmodulus}" ]] ; then
    echo "DANGER, WILL ROBINSON"
    echo "KEY ${1}.key AND CERT ${1}.crt HAVE MISMATCHED MODULUS"
    echo "IT IS HIGHLY LIKELY THIS IS A PROBLEM"
    exit 4
fi
