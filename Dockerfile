from ubuntu

RUN apt install wget
ENTRYPOINT ["/workspace/build.sh"]