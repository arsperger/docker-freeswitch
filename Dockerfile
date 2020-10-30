FROM scratch
ADD freeswitch_img.tar.gz /
COPY config/freeswitch /etc/freeswitch
CMD ["/usr/bin/freeswitch", "-nc", "-nf", "-nonat"]