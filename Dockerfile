from ubuntu

RUN apt update
RUN apt install -y wget
ENTRYPOINT ["/workspace/build.sh"]