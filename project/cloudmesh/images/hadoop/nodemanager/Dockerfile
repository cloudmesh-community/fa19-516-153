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

#Running the run.sh file during container creation
CMD ["/run.sh"]