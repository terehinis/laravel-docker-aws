#!/bin/bash

#sed "s/NEWRELIC_KEY/$NEWRELIC_KEY/g" -i /usr/local/etc/php/conf.d/php-newrelic.ini
#sed "s/NEWRELIC_PROJCT/$NEWRELIC_PROJCT/g" -i /usr/local/etc/php/conf.d/php-newrelic.ini
chmod -R 777 /var/www/storage
/var/www/migration.sh
#./app/console --no-interaction doctrine:migrations:migrate --env=prod

#./app/console --no-interaction doctrine:migrations:migrate --env=prod
chmod -R 777 /var/www/storage/
/var/www/migration.sh
#chown -R 33:33 /var/www
/usr/bin/python /usr/bin/supervisord -c /etc/supervisord.conf
