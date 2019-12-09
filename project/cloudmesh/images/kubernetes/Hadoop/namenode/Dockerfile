#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/namenode/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

#Providing values for future environment variables
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name

#Creating a directory inside the docker image
RUN mkdir -p /hadoop/dfs/name

#Creating a volume for the docker image each time a container is started
VOLUME /hadoop/dfs/name

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Informing docker that the container listens on port 9870 at runtime
EXPOSE 9870

#Running the run.sh file during container creation
CMD ["/run.sh"]