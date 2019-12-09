#Refrred https://github.com/big-data-europe/docker-hadoop/blob/master/submit/Dockerfile

#Getting base hadoop image
FROM bde2020/hadoop-base

#Copying the run file to the desired location
COPY run.jar /opt/hadoop/applications/run.jar

#Setting up the environments
ENV JAR_FILEPATH="/opt/hadoop/applications/run.jar"
ENV CLASS_TO_RUN="run"
ENV PARAMS="/input /output"

#Copying the file into the docker image
ADD run.sh /run.sh

#Copying the file into the docker image
RUN chmod a+x /run.sh

#Running the run.sh file during container creation
CMD ["/run.sh"]
