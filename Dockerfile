FROM pihole/pihole:latest

RUN apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl unbound wget
RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash

COPY unbound-pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

# add service script for s6-overlay v3 added to pihole:2022.08
RUN mkdir -p /etc/s6-overlay/s6-rc.d/unbound
COPY unbound-run /etc/s6-overlay/s6-rc.d/unbound/run
RUN echo -n "longrun" > /etc/s6-overlay/s6-rc.d/unbound/type
RUN touch /etc/s6-overlay/s6-rc.d/user/contents.d/unbount

RUN unbound-anchor; unbound-checkconf

ENTRYPOINT /start-services.sh
