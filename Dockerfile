FROM openjdk:jre-alpine

RUN apk add --update openssl && \
    rm -rf /var/cache/apk/*

ADD pem2keystore.sh /

ENTRYPOINT ["/pem2keystore.sh"]
