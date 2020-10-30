FROM debian:buster as build_freeswitch

LABEL MAINTAINER="Arsen Semenov arsperger@gmail.com"

ENV DEB_BUILD_DEP="gcc git-core make libtool automake autoconf"

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg2 wget ngrep sngrep net-tools procps ${DEB_BUILD_DEP} \
        && /usr/bin/wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - \
        && /bin/echo "deb http://files.freeswitch.org/repo/deb/debian-release/ buster main" > /etc/apt/sources.list.d/freeswitch.list \
        && /bin/echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ buster main" >> /etc/apt/sources.list.d/freeswitch.list

RUN apt-get update && apt-get install -y freeswitch freeswitch-mod-console \
        freeswitch-mod-sofia freeswitch-mod-commands freeswitch-mod-json-cdr \
        freeswitch-mod-db freeswitch-mod-dptools freeswitch-mod-hash freeswitch-mod-dialplan-xml \
        freeswitch-mod-sndfile freeswitch-mod-native-file freeswitch-mod-tone-stream \
        freeswitch-mod-say-en freeswitch-mod-event-socket freeswitch-mod-loopback \
        freeswitch-mod-xml-curl freeswitch-mod-expr freeswitch-mod-httapi freeswitch-mod-local-stream \
        freeswitch-mod-spandsp freeswitch-mod-g723-1 freeswitch-mod-opus libfreeswitch-dev

WORKDIR /usr/local/src
RUN git clone https://github.com/xadhoom/mod_bcg729.git && cd mod_bcg729 && make && make install 

COPY script/ /tmp/freeswitch/
RUN /bin/bash -c "source /tmp/freeswitch/make_min_archive.sh"

RUN /bin/mkdir /tmp/build_image
RUN /bin/tar zxvf ./freeswitch_img.tar.gz -C /tmp/build_image

FROM scratch
COPY --from=build_freeswitch /tmp/build_image /
ADD config/freeswitch /etc/freeswitch
COPY script/run_tests.sh /usr/bin
HEALTHCHECK --interval=15s --timeout=5s CMD /usr/bin/run_tests.sh
CMD ["/usr/bin/freeswitch", "-nc", "-nf", "-nonat"]
