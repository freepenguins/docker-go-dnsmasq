FROM alpine:3.3

MAINTAINER joe <joe@valuphone.com>

LABEL   os="linux" \
        os.distro="alpine" \
        os.version="3.3"

LABEL   app.name="go-dnsmasq" \
        app.type="pod-service" \
        app.service="resolve" \
        app.version="1.0.0"

ENV     GODNSMASQ_VERSION=1.0.0

RUN     apk add --update curl \
            && curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /usr/sbin/go-dnsmasq \
            && chmod +x /usr/sbin/go-dnsmasq \
            && apk del curl \
            && rm -rf /var/cache/apk/*

ENV     DNSMASQ_SEARCH='default.svc.cluster.local,svc.cluster.local,cluster.local' \
        DNSMASQ_SERVERS='172.17.1.10,10.0.80.11,10.0.80.12,208.67.222.222' \
        DNSMASQ_APPEND=true \
        DNSMASQ_DEFAULT=true

CMD ["/usr/sbin/go-dnsmasq"]
