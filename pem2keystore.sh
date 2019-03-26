#!/bin/sh
set -e

if [ ! -f "$CERT_LOCATION" ] ; then
    echo 'No $CERT_LOCATION is not a file!'
    exit 1
fi

if [ -z "$KEYSTORE_LOCATION" ] ; then
    echo 'No $KEYSTORE_LOCATION set!'
    exit 1
fi

if [ -z "$KEYSTORE_PASSWORD" ] ; then
    echo 'No $KEYSTORE_PASSWORD set!'
    exit 1
fi

if [ -z "$KEY_ALIAS" ] ; then
    KEY_ALIAS='mykey'
fi


if [ -z "$KEY_LOCATION" ] ; then
    # If only a cert is given, create a truststore
    keytool -keystore "$KEYSTORE_LOCATION" -import -file "$CERT_LOCATION" -storepass "$KEYSTORE_PASSWORD" -noprompt -alias "$KEY_ALIAS"
else
    # If a key and a cert is given, create a keystore
    PEMFILE=$(mktemp)
    PKCS12FILE=$(mktemp)
    cat "$KEY_LOCATION" "$CERT_LOCATION" > $PEMFILE

    # Create pkcs12 file
    openssl pkcs12 -export -out $PKCS12FILE -in $PEMFILE -passout pass:"$KEYSTORE_PASSWORD"

    # Create Java Keystore
    keytool -v -importkeystore -srckeystore $PKCS12FILE -srcstoretype PKCS12 -destkeystore "$KEYSTORE_LOCATION" -storepass "$KEYSTORE_PASSWORD" -srcstorepass "$KEYSTORE_PASSWORD" -alias 1 -destalias "$KEY_ALIAS"

    rm $PEMFILE $PKCS12FILE
fi
