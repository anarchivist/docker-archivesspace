# VERSION 0.1

FROM ubuntu:12.04
MAINTAINER Mark Matienzo <mark@matienzo.org>

# Get the ArchivesSpace dependencies...
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise-security main universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN cat /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server openjdk-7-jre-headless pwgen wget unzip

# Add the startup script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# Fetch ArchivesSpace and make it run-ready
ADD https://github.com/archivesspace/archivesspace/releases/download/v1.0.9/archivesspace-v1.0.9.zip /archivesspace.v1.0.9.zip
RUN unzip /archivesspace.v1.0.9.zip -d /
RUN rm /archivesspace.v1.0.9.zip
RUN chmod 755 /archivesspace/archivesspace.sh

# Get the MySQL connector
ADD http://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.31/mysql-connector-java-5.1.31.jar /archivesspace/lib/mysql-connector-java-5.1.31.jar 

# Expose the application's ports:
# 8080: Staff UI
# 8081: Public UI
# 8089: Backend API
# 8090: Solr
EXPOSE 8080 8081 
EXPOSE 8089 8090

CMD ["/bin/bash", "/start.sh"]
