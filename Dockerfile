FROM resin/rpi-raspbian
MAINTAINER kaiwa <github@kawa.in>

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

RUN echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y -t stretch \
    google-cloud-print-connector

ARG admin-password
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

COPY gcp-init.sh /opt/gcp-init.sh

ARG share-scope
ARG proxy-name=raspberry
RUN /opt/gcp-init.sh "${share-scope}" "${proxy-name}"

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK CMD curl -f http://localhost:631/ || exit 1
