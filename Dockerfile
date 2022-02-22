from jiangjqian/buildkernel

USER root
RUN apt-get update
RUN apt-get install -y tmux
USER richard

ENTRYPOINT ["tail", "-f", "/dev/null"]
