FROM resin/rpi-raspbian
MAINTAINER Kuba Kuźma <kuba@jah.pl>

RUN echo "ServerName cups:631/version=1.1" >> /etc/cups/client.conf && \
    echo "Encryption Never" >> /etc/cups/client.conf && \
    echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade && \
    apt-get install -y -t stretch \
      google-cloud-print-connector

CMD ["gcp-cups-connector", "--log-to-console", "--config-filename", "/config/gcp-cups-connector.config.json"]
