from openjdk:11
COPY apache-jena-4.3.2.tar.gz .
RUN tar xfvz apache-jena-4.3.2.tar.gz
ENV JENA_HOME /apache-jena-4.3.2
ENV IRISH_GEN_HOME /workspace
ENTRYPOINT ["/workspace/utils/check_file_syntax.sh"]