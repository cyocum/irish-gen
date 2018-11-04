from ubuntu

RUN apt update
RUN apt install wget
ENTRYPOINT ["/workspace/build.sh"]