
#!/bin/bash
echo "\e[32m Generando claves"

echo "\e[32m			Generando clave cliente.key \e[0m"
sudo openssl genrsa -des3  -out cliente.key 2048

echo "\e[32m			Generando clave server.key \e[0m"
sudo openssl genrsa -des3 -out server.key 2048

echo "\e[32m			Generando server.pem \e[0m"
sudo openssl rsa -in server.key -out server.pem

#Generando certificados
echo "\e[32m Generando certificados \e[0m"

echo "\e[32m			Generando certificado cliente.csr \e[0m"
sudo openssl req -new -key cliente.key -out cliente.csr

echo "\e[32m			Generando certificado server.csr \e[0m"
sudo openssl req -new -key server.key -out server.csr

# Certificados autofirmados
echo "\e[32m Generando autofirmas \e[0m"
echo "\e[32m			Generando autofirma cliente.crt \e[0m"
sudo openssl x509 -req -days 360 -in cliente.csr -signkey server.key -out cliente.crt

echo "\e[32m			Generando autofirma server.crt \e[0m"
sudo openssl x509 -req -days 360 -in server.csr -signkey server.key -out server.crt

echo "\e[32m			Exportando a cliente.p12 \e[0m"
sudo openssl pkcs12 -export -in cliente.crt -inkey server.key -out cliente.p12 -name "Certificado"
echo "\e[32m Fin \e[0m"
