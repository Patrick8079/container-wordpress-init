FROM docker.io/library/wordpress:php8.3-apache

COPY ./scripts/init.sh /root/init.sh
RUN chmod +x /root/init.sh

RUN apt update && \
    apt upgrade -y && \
    apt autoremove && \
    apt install -y \
    wget

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar --info&& \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN apt remove -y \
    wget