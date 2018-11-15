from openjdk:11
RUN wget https://www-eu.apache.org/dist/jena/binaries/apache-jena-3.9.0.tar.gz 
RUN tar xfvz apache-jena-3.9.0.tar.gz
RUN sed -i 's/WARN/INFO/g' ./apache-jena-3.9.0/jena-log4j.properties
RUN mkdir -p /workspace/LL /workspace/Duanaire_Finn /workspace/Laud_Misc_610 /workspace/LLAdd /workspace/LU /workspace/NLS.Adv.72.1.1 /workspace/Rawl_B502
COPY build.sh /workspace/
COPY LL /workspace/LL
COPY Duanaire_Finn /workspace/Duanaire_Finn
COPY Laud_Misc_610 /workspace/Laud_Misc_610
COPY LLAdd /workspace/LLAdd
COPY LU /workspace/LU
COPY NLS.Adv.72.1.1 /workspace/NLS.Adv.72.1.1
COPY Rawl_B502 /workspace/Rawl_B502
RUN chmod 777 /workspace/build.sh
ENTRYPOINT ["/workspace/build.sh"]