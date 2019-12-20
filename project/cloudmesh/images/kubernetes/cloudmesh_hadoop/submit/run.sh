#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/submit/run.sh

#!/bin/bash

$HADOOP_PREFIX/bin/hadoop jar $JAR_FILEPATH $CLASS_TO_RUN $PARAMS 
