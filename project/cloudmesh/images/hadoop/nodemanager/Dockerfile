#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nodemanager/Dockerfile

#Getting base hadoop image
FROM cloudmesh/docker-hadoop

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Informing docker that the container listens on port 8042 at runtime
EXPOSE 8042

FROM ubuntu

#Updating the apt package index
RUN apt-get update

#Installing dos2unix
RUN apt-get install dos2unix

#Dealing with docker line endings
#RUN dos2unix ./entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

#Running the run.sh file during container creation
CMD ["/run.sh"]