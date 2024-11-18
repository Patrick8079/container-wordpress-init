#!/bin/sh
set -e

sleep 20

if [ ! -f wp-config.php ]; then
    echo "WordPress not found in $PWD!"
    ( set -x; sleep 18 )
fi

if ! $(wp core is-installed); then
    echo "Initializing WordPress install!"

    wp core install \
        --url="$WP_URL" \
        --admin_user=$WP_USER \
        --admin_password=$WP_PASSWORD \
        --admin_email=$WP_EMAIL \
        --title="$WP_TITLE" \
        --skip-email \
        --skip-plugins \
        --allow-root
        
    wp core update \
        --allow-root
    
    wp core update-db \
        --allow-root

    wp option update blogdescription "$WP_DESCRIPTION" \
        --allow-root
    
    wp config set WP_DEBUG $WP_DEBUG --raw \
        --allow-root
fi