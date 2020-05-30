from openjdk:11
COPY static/apache-jena-3.14.0.tar.gz .
RUN tar xfvz apache-jena-3.14.0.tar.gz
RUN sed -i 's/WARN/INFO/g' ./apache-jena-3.14.0/jena-log4j.properties
RUN sed -i 's/System\.err/System\.out/g' ./apache-jena-3.14.0/jena-log4j.properties
RUN mkdir -p /workspace/LL /workspace/Duanaire_Finn /workspace/Laud_Misc_610 /workspace/LLAdd /workspace/LU /workspace/NLS.Adv.72.1.1 /workspace/Rawl_B502 /workspace/utils
COPY LL /workspace/LL
COPY Duanaire_Finn /workspace/Duanaire_Finn
COPY Laud_Misc_610 /workspace/Laud_Misc_610
COPY LLAdd /workspace/LLAdd
COPY LU /workspace/LU
COPY NLS.Adv.72.1.1 /workspace/NLS.Adv.72.1.1
COPY Rawl_B502 /workspace/Rawl_B502
COPY utils /workspace/utils
ENV JENA_HOME /apache-jena-3.14.0
ENV IRISH_GEN_HOME /workspace
RUN chmod 777 /workspace/utils/check_file_syntax.sh
ENTRYPOINT ["/workspace/utils/check_file_syntax.sh"]