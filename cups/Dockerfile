FROM resin/rpi-raspbian
MAINTAINER kaiwa <github@kawa.in>

RUN /usr/bin/apt-get update && /usr/bin/apt-get install -y \
  sudo \
  locales \
  whois \
  cups \
  cups-client \
  cups-bsd \
  printer-driver-all \
  hpijs-ppds \
  hp-ppd \
  hplip

RUN sed -i "s/^#\ \+\(en_US.UTF-8\)/\1/" /etc/locale.gen \
  && locale-gen en_US en_US.UTF-8

ENV LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LANGUAGE=en_US:en

ARG CUPS_PASSWORD

RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd $CUPS_PASSWORD) \
  print \
  && sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/lib/apt/lists/partial

COPY cupsd.conf /etc/cups/cupsd.conf

CMD ["/usr/sbin/cupsd", "-f"]

HEALTHCHECK CMD curl -f http://localhost:631/ || exit 1
