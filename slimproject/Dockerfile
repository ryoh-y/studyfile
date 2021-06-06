# ==================================================================
#	date	: 2021/06/03
#	author	: 
#	outline	: Linux CentOS Setup(yum)
#	file	: install.sh

#CONTAINER_NAME=project
#docker run -d -it -p "3306:3306"  -p "8000:80" --name CONTAINER_NAME --privileged centos:7  /sbin/init
#docker exec -it webapp /bin/bash
# ==================================================================

FROM centos:7

RUN yum -y update && yum clean all
RUN yum -y install epel-release
RUN yum -y --disablerepo=epel install expect httpd-devel mod_ssl php-devel php-pear mariadb-server php-mbstring php-xml php-gd php-mysql || exit 1

RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN localedef -f EUC-JP  -i ja_JP ja_JP.eucJP


RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum -y install --enablerepo=remi-php56 -y php php-devel php-gd php-mbstring php-mcrypt php-mysqlnd php-pear php-xml php-opcache

CMD ["httpd", "-D", "FOREGROUND"]