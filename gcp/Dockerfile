FROM resin/rpi-raspbian
MAINTAINER kaiwa <github@kawa.in>

RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list && \
    apt-get update
    
RUN apt-get install -y -t stretch --no-upgrade \
    google-cloud-print-connector

ARG GCP_SHARE_SCOPE
ARG GCP_NAME

RUN gcp-cups-connector-util init --share-scope "$GCP_SHARE_SCOPE" --proxy-name="$GCP_NAME" --local-printing-enable --cloud-printing-enable

COPY client.conf /etc/cups/client.conf

CMD ["gcp-cups-connector", "--log-to-console"]
