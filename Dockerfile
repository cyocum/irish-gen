from alpine

RUN apk add --no-cache --update --upgrade openjdk8 wget tar
RUN wget https://www-eu.apache.org/dist/jena/binaries/apache-jena-3.9.0.tar.gz
RUN tar xfvz apache-jena-3.9.0.tar.gz
ENV JENA_HOME=./apache-jena-3.9.0
COPY build.sh .
RUN chmod +x /build.sh
CMD ["./build.sh"]