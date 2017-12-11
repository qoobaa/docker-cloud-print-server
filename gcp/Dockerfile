FROM resin/rpi-raspbian
MAINTAINER kaiwa <github@kawa.in>

RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list && \
    apt-get update && apt-get upgrade

RUN apt-get install -y -t stretch \
    google-cloud-print-connector

COPY client.conf /etc/cups/client.conf

CMD ["gcp-cups-connector", "--log-to-console", "--config-filename", "/config/gcp-cups-connector.config.json"]
