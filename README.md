This repository contains a recipe for making a [Docker](http://docker.io/)
container for the [ArchivesSpace](http://github.com/archivesspace/archivesspace)
archival management system, with MySQL and OpenJDK 7 JRE. To build, make
sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone
this repo somewhwere, and then run:

    docker build -t <yourname>/archivesspace .

Once the container is built, you can run it as follows:

    docker run -d <yourname> archivesspace

To determine which ports ArchivesSpace is running on, use the following command:

    docker ps

The port that forwards to 8080 on the container is the port for the staff 
user interface, and the port that forwards to port 8081 is for the public UI.
 
