# ==================================================================
#	date	: 2021/06/03
#	author	: 
#	outline	: Linux CentOS Setup(yum)
#	file	: install.sh

# ==================================================================
USER_NAME=webapp
ARCHIVE_DIR=/root/install


#/* UserSettiong */
useradd $USER_NAME
#echo $USER_NAME| passwd $USER_NAME
mkdir -p /home/$USER_NAME/web

yum -y install sudo gcc make


timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=ja_JP.utf8 
localedef -f EUC-JP  -i ja_JP ja_JP.eucJP

localectl set-locale LANG=ja_JP.utf8 
source /etc/locale.conf 


#/* mysql */

yum -y install http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum -y install mysql-community-server

mysql -h mysql56  -u root -p -e "GRANT ALL ON webapp.* TO webapp IDENTIFIED BY '$USER_NAME';";
mysql -h mysql56  -u root -p -e "FLUSH PRIVILEGES;"

#show databases
#select user, host from mysql.user;
#show grants for '$USER_NAME'@'%';



#mysql -h mysql56  -u root -p -e "GRANT ALL ON webapp.* TO webapp IDENTIFIED BY 'webapp';";
#mysql -h mysql56  -u root -p -e "FLUSH PRIVILEGES;"
#show databases
#select user, host from mysql.user;
#show grants for 'webapp'@'%';


#mysql  -e "CREATE DATABASE webapp;"
#mysql  -e "GRANT ALL ON webapp.* TO webapp IDENTIFIED BY 'webapp';"
#mysql  -e "FLUSH PRIVILEGES;"

#---------------------------------------------------------------------------

#/* apache */
#/* PHP */

yum -y install --enablerepo=remi-php56 -y php php-opcache php-devel php-mbstring php-mcrypt
yum -y install --enablerepo=remi-php56 -y php-mysqlnd php-phpunit-PHPUnit php-pecl-xhprof redis
yum -y install --enablerepo=remi-php56 -y php-yaml php-xml
yum -y install --enablerepo=remi-php56 httpd php php-common php-cli php-curl php-mysql php-mongodb php56-php-gd.x86_64
#libxml2-devel

#apache2 available.
#package libapache2-mod-php available.
#package php-gb available.

#------------------------------------------------------------------------
cd /var/www/html
echo "<?php phpinfo(); ?>;" > phpinfo.php


cp -r ARCHIVE_DIR/* /home/$USER_NAME/web
cd /home/$USER_NAME/web

ln -s /home/$USER_NAME/web /var/www/html

systemctl start httpd
systemctl enable httpd
#------------------------------------------------------------------------
#web版

mysql  -u $USER_NAME -D $USER_NAME < mysql_stg_dump_20170705.sql;

#web用環境構築
cd $USER_NAME/web
#chmod +x app/propel
#chmod +x website_setup.sh

./website_setup.sh

#管理画面用用環境構築
npm install bower webpack -no-bin-links

npm install autoprefixer-core -no-bin-links
npm install csswring -no-bin-links
npm install bower-webpack-plugin -no-bin-links
npm install lodash -no-bin-links
npm install babel-core -no-bin-links
npm install babel-loader -no-bin-links
npm install moment react js-cookie jquery -no-bin-links
npm install style-loader json-loader -no-bin-links
npm install css-loader postcss-loader less-loader less -no-bin-links

#npm module
npm update -no-bin-links
npm prune
bower update --allow-root
bower prune --allow-root

WEBPACK_MODE=devlocal webpack --display-error-details
