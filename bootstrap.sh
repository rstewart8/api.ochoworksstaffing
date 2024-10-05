#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD="password"
PROJECTFOLDER="ochoworksstaffing"
APP="ochoworksstaffing.com"
APPNAME="ochoworksstaffing"
APPNAMESHORT="ochoworksstaffing"
DBNAME="ochoworksstaffing"
ENVIRONMENT="development"
HOST="http://${APP}/"
ROOT="/var/www/vhosts"
MYSSQLADMIN='mradmin'
REPOOWNER='mradmin'
MYSQLPASSWORD="password"

## create the repo owner user
sudo useradd -d "/home/${REPOOWNER}" -m "${REPOOWNER}" -p "${PASSWORD}"
sudo usermod --shell "/bin/bash ${REPOOWNER}"
sudo usermod -aG www-data "${REPOOWNER}"

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 
sudo apt-get install -y apache2

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

sudo apt -y install php8.3
sudo apt-get install -y php8.3-json
sudo apt-get install -y php8.3-mysqlnd
sudo apt-get install -y php8.3-xml
sudo apt-get install -y php8.3-intl
sudo apt-get install -y php8.3-mbstring
sudo apt-get install -y php8.3-curl
# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName "vb.api.${APP}"
    RewriteEngine On
    DocumentRoot "${ROOT}/${PROJECTFOLDER}/www"
    <Directory "${ROOT}/${PROJECTFOLDER}/www">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/ochoworksstaffing.conf

sudo a2ensite ochoworksstaffing.conf
sudo a2enmod rewrite

sudo mkdir "/var/log/${APPNAMESHORT}"
touch "/var/log/${APPNAMESHORT}/logger.log"
touch "/var/log/${APPNAMESHORT}/error.log"

suphp do chown www-data:www-data -R "/var/log/${APPNAMESHORT}"
sudo chown www-data:www-data "/var/log/${APPNAMESHORT}/logger.log"
sudo chown www-data:www-data "/var/log/${APPNAMESHORT}/error.log"
sudo chown "${REPOOWNER}:${REPOOWNER}" -R "/etc/${APPNAME}"
sudo chmod 775 "/var/log/${APPNAMESHORT}/*.log"

sudo mkdir "/var/spool/${APPNAMESHORT}" 
sudo mkdir "/var/spool/${APPNAMESHORT}/attachments"
sudo mkdir "/var/spool/${APPNAMESHORT}/files"
sudo mkdir "/var/spool/${APPNAMESHORT}/files/zip"
sudo chmod 777 "/var/spool/${APPNAMESHORT}/files"

sudo chown "${REPOOWNER}:${REPOOWNER}" -R "/var/spool/${APPNAMESHORT}"
sudo chown www-data:www-data -R "/var/spool/${APPNAMESHORT}/files"

# restart apache
service apache2 restart

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

sudo apt install -y mysql-server mysql-client

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQLPASSWORD}'"
mysql -u root -p"${MYSQLPASSWORD}" -e "CREATE USER 'mradmin'@'%' IDENTIFIED BY '${MYSQLPASSWORD}'"
mysql -u root -p"${MYSQLPASSWORD}" -e "GRANT ALL PRIVILEGES ON *.* TO 'mradmin'@'%' WITH GRANT OPTION"
mysql -u root -p"${MYSQLPASSWORD}" -e "FLUSH PRIVILEGES"
mysql -uroot -p"${MYSQLPASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${DBNAME}"

for sql_file in `ls ${ROOT}/${PROJECTFOLDER}/sqls/*.sql`; do echo "$sql_file"; mysql -uroot -p"$MYSQLPASSWORD" "${DBNAME}" < $sql_file ; done

for sql_file in `ls ${ROOT}/${PROJECTFOLDER}/sqls/dumps/*.sql`; do echo "$sql_file"; mysql -uroot -p"$MYSQLPASSWORD" "${DBNAME}" < $sql_file ; done

for sql_file in `ls ${ROOT}/${PROJECTFOLDER}/sqls/seedings/*.sql`; do echo "$sql_file"; mysql -uroot -p"$MYSQLPASSWORD" "${DBNAME}" < $sql_file ; done

sudo php /var/www/vhosts/ochoworksstaffing/sqls/seedings/seedEmployeeSkills.php

# Override any existing bind-address to be 0.0.0.0 to accept connections from host
echo "Updating my.cnf..."
sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
echo "[mysqld]" | sudo tee -a /etc/mysql/my.cnf
echo "bind-address=0.0.0.0" | sudo tee -a /etc/mysql/my.cnf
echo "default-time-zone='+00:00'" | sudo tee -a /etc/mysql/my.cnf

sudo ufw allow 3306

sudo service mysql restart

