FROM ubuntu
MAINTAINER Mark Matienzo <mark@matienzo.org>
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN cat /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server openjdk-7-jre-headless pwgen python-setuptools vim-tiny wget unzip coreutils
RUN easy_install supervisor
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN wget https://github.com/archivesspace/archivesspace/releases/download/v0.6.2/archivesspace.v0.6.2.zip
RUN unzip archivesspace.v0.6.2.zip -d /
RUN chmod 755 /archivesspace/archivesspace.sh
RUN wget -O /archivesspace/lib/mysql-connector-java-5.1.25.jar http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.25/mysql-connector-java-5.1.25.jar  

EXPOSE 8080 8081 8089 8090
CMD ["/bin/bash", "/start.sh"]
