#!BuildTag: 389-ds-container
FROM opensuse/tumbleweed:latest
MAINTAINER wbrown@suse.de

EXPOSE 3389 3636

RUN zypper install -y 389-ds timezone openssl nss_synth

COPY nsswitch.conf /etc/nsswitch.conf

RUN mkdir -p /data/config && \
    mkdir -p /data/ssca && \
    mkdir -p /data/run && \
    mkdir -p /var/run/dirsrv && \
    ln -s /data/config /etc/dirsrv/slapd-localhost && \
    ln -s /data/ssca /etc/dirsrv/ssca && \
    ln -s /data/run /var/run/dirsrv && \
    chmod -R 777 /data /etc/dirsrv

# ENV DS_DM_PASSWORD
# ENV DS_MEMORY_PERCENTAGE
# ENV DS_REINDEX
# ENV SUFFIX_NAME
# ENV DS_STARTUP_TIMEOUT

VOLUME /data

HEALTHCHECK --start-period=5m --timeout=5s --interval=5s --retries=2 \
    CMD /usr/lib/dirsrv/dscontainer -H

CMD [ "/usr/lib/dirsrv/dscontainer", "-r" ]

