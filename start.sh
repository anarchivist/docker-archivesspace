#!/bin/bash

if [ ! -f /mysql-configured ]; then
	/usr/bin/mysqld_safe & 
	sleep 10s
	MYSQL_PASSWORD=`pwgen -c -n -1 12`
	AS_PASSWORD=`pwgen -c -n -1 12`
	echo mysql root password: $MYSQL_PASSWORD
	echo mysql archivesspace password: $AS_PASSWORD
	echo $MYSQL_PASSWORD > /mysql-root-pw.txt
	echo $AS_PASSWORD > /mysql-aspace-pw.txt
	cat << ENDL >> /archivesspace/config/config.rb
	AppConfig[:db_url] = "jdbc:mysql://localhost:3306/archivesspace?user=archivesspace&password=$AS_PASSWORD&useUnicode=true&characterEncoding=UTF-8"
ENDL
	mysqladmin -u root password $MYSQL_PASSWORD 
	mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE archivesspace DEFAULT CHARACTER SET UTF8; GRANT ALL PRIVILEGES ON archivesspace.* to 'archivesspace'@'localhost' IDENTIFIED BY '$AS_PASSWORD'; FLUSH PRIVILEGES;" 
	touch /mysql-configured
	bash /archivesspace/scripts/setup-database.sh
	killall mysqld
	sleep 10s
fi

supervisord -n
