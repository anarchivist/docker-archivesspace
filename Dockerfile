# VERSION 0.1

FROM ubuntu
MAINTAINER Mark Matienzo <mark@matienzo.org>

# Get the ArchivesSpace dependencies...
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN cat /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server openjdk-7-jre-headless pwgen python-setuptools vim-tiny wget unzip coreutils
RUN easy_install supervisor

# Add the startup scripts and supervisord configuration
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ADD ./supervisord.conf /etc/supervisord.conf

# Fetch ArchivesSpace and make it run-ready
ADD https://github.com/archivesspace/archivesspace/releases/download/v0.6.2/archivesspace.v0.6.2.zip /tmp/
RUN unzip /tmp/archivesspace.v0.6.2.zip -d /
RUN chmod 755 /archivesspace/archivesspace.sh

# Get the MySQL connectir
ADD http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.25/mysql-connector-java-5.1.25.jar /archivesspace/lib/ 

# Expose the application's ports:
# 8080: Staff UI
# 8081: Public UI
# 8089: Backend API
# 8090: Solr
EXPOSE 8080 8081 8089 8090

CMD ["/bin/bash", "/start.sh"]
