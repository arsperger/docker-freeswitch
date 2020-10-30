FROM scratch
ADD freeswitch_img.tar.gz /
COPY config/freeswitch /etc/freeswitch
COPY script/run_tests.sh /usr/bin
HEALTHCHECK --interval=15s --timeout=5s CMD /usr/bin/run_tests.sh
CMD ["/usr/bin/freeswitch", "-nc", "-nf", "-nonat"]