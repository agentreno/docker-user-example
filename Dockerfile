FROM ubuntu:latest

RUN groupadd --gid 1001 docker
RUN useradd --uid 1001 --gid docker --shell /sbin/nologin docker
USER docker

ENTRYPOINT ["sleep", "infinity"]
