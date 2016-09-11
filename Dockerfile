FROM resin/rpi-raspbian
MAINTAINER kaiwa <github@kawa.in>

ARG share-scope
ARG admin-password
ARG proxy-name=raspberry

RUN apt-get update && apt-get install -y \
  sudo \
  locales \
  whois \
  cups \
  cups-client \
  cups-bsd \
  printer-driver-all \
  hpijs-ppds \
  hp-ppd \
  hplip \
  supervisor

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen \
  && locale-gen en_US en_US.UTF-8

ENV LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LANGUAGE=en_US:en

RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd ${admin-password}) \
  print \
  && sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/lib/apt/lists/partial

COPY config/cupsd.conf /etc/cups/cupsd.conf
EXPOSE 631

RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y -t stretch \
    google-cloud-print-connector

RUN gcp-cups-connector-util init --share-scope "${share-scope}" --proxy-name="${proxy-name}" --local-printing-enable --cloud-printing-enable \
    && mv gcp-cups-connector.config.json /home/print/gcp-cups-connector.config.json \
    && chown print /home/print/gcp-cups-connector.config.json

RUN mkdir -p /var/log/supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

