FROM alpine
MAINTAINER David Personette <dperson@gmail.com>

# Install openvpn
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash curl ip6tables iptables openvpn \
                shadow shadow-login tini tzdata supervisor && \
    addgroup -S vpn && \
    rm -rf /tmp/*

COPY openvpn.sh /usr/bin/

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -LSs 'https://api.ipify.org'

VOLUME ["/vpn"]

# Supervisor Config
COPY supervisord.conf /etc/supervisord.conf

# ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/openvpn.sh"]
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]