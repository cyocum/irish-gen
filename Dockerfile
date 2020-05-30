from openjdk:11
COPY apache-jena-3.14.0.tar.gz .
RUN tar xfvz apache-jena-3.14.0.tar.gz
RUN sed -i 's/WARN/INFO/g' ./apache-jena-3.14.0/jena-log4j.properties
RUN sed -i 's/System\.err/System\.out/g' ./apache-jena-3.14.0/jena-log4j.properties
ENV JENA_HOME /apache-jena-3.14.0
RUN chmod 777 /workspace/utils/check_file_syntax.sh
ENTRYPOINT ["/workspace/utils/check_file_syntax.sh"]