Bash
#!/bin/bash

# Create log directory
mkdir -p logs

# Generate root CA certificate
openssl req -x509 -newkey rsa:4096 -keyout rootca.key -out rootca.crt -days 7299 -config config.cnf -extensions v3_ca

# Generate intermediate CA certificate
openssl req -x509 -newkey rsa:3072 -keyout intermediate.key -out intermediate.crt -days 5474 -config config.cnf -extensions v3_ca

# Create PEM file from configuration file
cat rootca.crt intermediate.crt > pem.crt

# Print out all 3 certificates in a chain
openssl verify -verbose -CAfile rootca.crt intermediate.crt pem.crt

# Log all certificates created
echo "Root CA certificate: rootca.crt" >> logs/certificates.log
echo "Intermediate CA certificate: intermediate.crt" >> logs/certificates.log
echo "PEM file: pem.crt" >> logs/certificates.log

exit 0
