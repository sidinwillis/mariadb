FROM webhippie/alpine:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

#ENV LC_ALL=en_GB.UTF-8

VOLUME ["/var/lib/mysql", "/var/lib/backup"]

EXPOSE 3306

WORKDIR /root
CMD ["/bin/s6-svscan", "/etc/s6"]

ENV CRON_ENABLED false

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories && \
  apk update && \
  mkdir -p \
    /var/lib/mysql && \
  groupadd \
    -g 1000 \
    mysql && \
  useradd \
    -u 1000 \
    -d /var/lib/mysql \
    -g mysql \
    -s /bin/bash \
    -m \
    mysql && \
  apk add \
    mariadb-common='10.1.32-r0' \
    mariadb='10.1.32-r0' \
    mariadb-client='10.1.32-r0' && \
  rm -rf \
    /var/cache/apk/* \
    /etc/mysql/* \
    /var/lib/mysql/*

ADD rootfs /
