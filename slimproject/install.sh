# ==================================================================
#	date	: 2021/06/03
#	author	: LINUX
#	outline	: Linux CentOS Setup(yum)
#	file	: install.sh
# ==================================================================
##PASS  -----------------
ARCHIVE_DIR="/root/install"
WORK_DIR="/usr/local/src"
ROOT_DIR="/var/www/html"


##LINUX BASIC -----------------
timedatectl set-timezone Asia/Tokyo
localectl set-locale LANG=ja_JP.utf8 
localedef -f EUC-JP  -i ja_JP ja_JP.eucJP

localectl set-locale LANG=ja_JP.utf8 
source /etc/locale.conf 




##LINUX BASIC -----------------

yum install epel-release

yum install httpd







RUN source /etc/locale.conf 

CMD ["httpd", "-D", "FOREGROUND"]

LOG_DIR="$ARCHIVE_DIR/log"


systemctl start httpd   #<--起動
systemctl enable httpd   #<--自動起動


timedatectl set-timezone Asia/Tokyo
localedef -f UTF-8 -i ja_JP ja_JP
localedef -f EUC-JP  -i ja_JP ja_JP.eucJP

localectl set-locale LANG=ja_JP.utf8 
source /etc/locale.conf 

useradd XXX -M
passwd XXX;

#composer install
cd $ROOT_DIR
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

cp /root/install/composer.json /var/www/html/composer.json
php composer.phar install

#composer slim download -----------------
cp -r -f $ARCHIVE_DIR/ /var/www/html
#cp -f /var/www/html/vendor/slim/slim/.htaccess /var/www/html/public/.htaccess


### command slim act
#php -S 0.0.0.0:8000

#lsof -i:0.0.0.0:8000
#ps ax | grep php