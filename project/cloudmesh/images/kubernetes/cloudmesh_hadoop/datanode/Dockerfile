#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/datanode/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Checking the health of the container
HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

#Providing values for future environment variables
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data

#Creating a directory inside the docker image
RUN mkdir -p /hadoop/dfs/data

#Creating a volume for the docker image each time a container is started
VOLUME /hadoop/dfs/data

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Informing docker that the container listens on port 9864 at runtime
EXPOSE 9864

#Running the run.sh file during container creation
CMD ["/run.sh"]
