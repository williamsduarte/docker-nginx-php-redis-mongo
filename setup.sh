#!/bin/bash
# Change access rights for the Laravel folders
# in order to make Laravel able to access
# cache and logs folder.
chgrp -R www-data storage bootstrap/cache
chown -R www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

chgrp -R www-data storage storage/framework/cache
chown -R www-data storage storage/framework/cache
chmod -R 775 storage storage/framework/cache

chgrp -R www-data storage storage/app
chown -R www-data storage storage/app
chmod -R 775 storage storage/app

chgrp -R www-data storage storage/framework/views
chown -R www-data storage storage/framework/views
chmod -R 775 storage storage/framework/views

chgrp -R www-data storage storage/logs
chown -R www-data storage storage/logs
chmod -R 777 storage storage/logs

# Create the symbolic link
ln -s public html
sleep 5

#Instaler extesion php 7.4 mongo
apt-get install php7.4-mongodb --assume-yes
sleep 5

# access to the folder structure
composer require jenssegers/mongodb --ignore-platform-reqs
sleep 5

composer install
sleep 5

composer require predis/predis --ignore-platform-reqs
sleep 5

composer require mongodb/mongodb --ignore-platform-reqs
sleep 5

/etc/init.d/php7.4-fpm restart
sleep 5

php artisan key:generate
php artisan migrate:fresh --seed
sleep 5

apt-get install --reinstall ca-certificates

echo "* * * * * php /usr/share/nginx/artisan schedule:run 1>> /dev/null 2>&1" >> /var/spool/cron/crontabs/root
crontab /var/spool/cron/crontabs/root
service cron restart

apt-get update

echo "Tudo pronto!!!"