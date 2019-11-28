#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/resourcemanager/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Informing docker that the container listens on port 8088 at runtime
EXPOSE 8088

#Running the run.sh file during container creation
CMD ["/run.sh"]










