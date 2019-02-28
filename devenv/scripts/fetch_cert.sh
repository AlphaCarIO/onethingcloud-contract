#!/bin/bash

URL=127.0.0.1:8443

if [ -n "$1" ]; then
    URL=$1
fi

STR=${URL/:/_}

echo STR=${STR}

isDarwin=`uname -a|grep Darwin`

echo 'isDarwin:'$isDarwin

if [ -n "$isDarwin" ]; then
    echo 'enter mac...'
    openssl s_client -connect ${URL} -showcerts </dev/null 2>/dev/null \
    | openssl x509 -outform PEM > ca.crt
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt
else
    echo 'enter linux...'
    openssl s_client -connect ${URL} -showcerts </dev/null 2>/dev/null \
        | openssl x509 -outform PEM | sudo tee /usr/local/share/ca-certificates/${STR}.crt

    sudo update-ca-certificates
    #sudo service docker restart
fi

#curl https://nexus.alphacario.com:8089/v2/ --cacert 
#mkdir -p ~/.docker/certs.d/nexus.alphacario.com:8089/
#keytool -printcert -sslserver nexus.alphacario.com:8089 -rfc
