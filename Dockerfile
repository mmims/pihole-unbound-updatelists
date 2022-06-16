FROM pihole/pihole:latest

RUN apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl unbound wget
RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash

COPY start-services.sh /start-services.sh
COPY unbound-pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

RUN chmod +x /start-services.sh
RUN unbound-anchor; unbound-checkconf

ENTRYPOINT /start-services.sh
