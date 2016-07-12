FROM alpine:latest
MAINTAINER Josh Elsasser <josh@elsasser.ca>
EXPOSE 6667 6697

ENV BITLBEE_VERSION 3.4.2-r1

RUN apk add --no-cache sudo \
      bitlbee=$BITLBEE_VERSION \
      bitlbee-otr=$BITLBEE_VERSION \
    && rm -rf /var/cache/apk/*

RUN apk add --no-cache --allow-untrusted \
      --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
      bitlbee-facebook \
    && rm -rf /var/cache/apk/*

RUN mkdir /data

ADD bitlbee.conf.default /etc/bitlbee/bitlbee.conf.default
RUN chmod 644 /etc/bitlbee/bitlbee.conf.default

ADD motd.txt.default /etc/bitlbee/motd.txt.default
RUN chmod 644 /etc/bitlbee/motd.txt.default

RUN adduser -H -D bitlbee
RUN mkdir -p /var/lib/bitlbee/ /var/run/bitlbee
RUN chown -R bitlbee /var/lib/bitlbee/ /var/run/bitlbee

ADD docker-entrypoint.sh /entrypoint.sh

VOLUME /data
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [""]
