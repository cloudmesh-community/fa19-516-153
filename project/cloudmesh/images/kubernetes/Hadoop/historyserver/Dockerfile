#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/historyserver/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

#Providing values for future environment variables
ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline

#Creating a directory inside the docker image
RUN mkdir -p /hadoop/yarn/timeline

#Creating a volume for the docker image each time a container is started
VOLUME /hadoop/yarn/timeline

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Informing docker that the container listens on port 8188 at runtime
EXPOSE 8188

#Running the run.sh file during container creation
CMD ["/run.sh"]