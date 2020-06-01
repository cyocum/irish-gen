from openjdk:11
COPY apache-jena-3.15.0.tar.gz .
RUN tar xfvz apache-jena-3.15.0.tar.gz
ENV JENA_HOME /apache-jena-3.15.0
ENV IRISH_GEN_HOME /workspace
RUN chmod 777 /workspace/utils/check_file_syntax.sh
ENTRYPOINT ["/workspace/utils/check_file_syntax.sh"]