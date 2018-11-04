from alpine

WORKDIR /workspace/

RUN apk add --no-cache --update --upgrade openjdk8 wget tar
RUN wget https://www-eu.apache.org/dist/jena/binaries/apache-jena-3.9.0.tar.gz
RUN tar xfvz apache-jena-3.9.0.tar.gz
RUN chmod +x build.sh
CMD ["/workspace/build.sh"]