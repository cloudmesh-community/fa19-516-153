#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/submit/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Copying the jar file to the required destination
COPY WordCount.jar /opt/hadoop/applications/WordCount.jar

#Setting up the environments
ENV JAR_FILEPATH="/opt/hadoop/applications/WordCount.jar"
ENV CLASS_TO_RUN="WordCount"
ENV PARAMS="/input /output"

#Copying the file into the docker image
ADD run.sh /run.sh

#Changing the access persmissions of the file
RUN chmod a+x /run.sh

#Running the run.sh file during container creation
CMD ["/run.sh"]
