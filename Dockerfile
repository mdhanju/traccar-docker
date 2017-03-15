FROM java:8-jre-alpine

MAINTAINER Maninder Singh <singhmaninder21@gmail.com>

ENV TRACCAR_VERSION 3.10

WORKDIR /opt/traccar

RUN set -ex && \
    apk add --no-cache --virtual install-dependencies wget && \
    \
    wget -qO /tmp/traccar.zip https://github.com/tananaev/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    \
    apk del install-dependencies

EXPOSE 8082:8082 5000-5150:5000-5150 5000-5150:5000-5150/udp

ENTRYPOINT ["java"]

CMD ["-Djava.net.preferIPv4Stack=true", "-Xms512m", "-jar", "tracker-server.jar", "conf/traccar.xml"]
