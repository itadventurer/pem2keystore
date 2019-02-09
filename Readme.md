# PEM 2 Keystore

Creates a keystore from pem files.

## Usage

### Environment variables

* `CERT_LOCATION`: Location of the certificate (for a CA cert or the
  public key for a private key)
* `KEY_LOCATION`: Location of the private key (optional)
* `KEYSTORE_LOCATION`: Where to store the Keystore
* `KEYSTORE_PASSWORD`: Password of the Keystore
* `KEY_ALIAS`: Set the alias of the key in the Keystore (optional)

### Run it in Docker

```sh
docker run -v "`pwd`":/key/ \
   -e CERT_LOCATION=/key/cacert \
   -e KEYSTORE_LOCATION=/key/truststore \
   -e KEYSTORE_PASSWORD=changeme \
   azapps/pem2keystore
```

### Create Keystore (Truststore) for trusting a (CA) cert

```sh
CERT_LOCATION=cacert \
    KEYSTORE_LOCATION=truststore \
    KEYSTORE_PASSWORD=changeme \
    ./pem2keystore.sh
```

### Create Keystore for storing a private key and cert (public key)

```sh
CERT_LOCATION=cert \
    KEY_LOCATION=key \
    KEYSTORE_LOCATION=keystore \
    KEYSTORE_PASSWORD=changeme \
    ./pem2keystore.sh
```
