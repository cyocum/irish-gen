from ubuntu

RUN apt install -y wget
ENTRYPOINT ["/workspace/build.sh"]