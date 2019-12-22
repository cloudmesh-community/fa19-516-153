#!/bin/bash

#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/submit/run.sh

$HADOOP_PREFIX/bin/hadoop jar $JAR_FILEPATH $CLASS_TO_RUN $PARAMS 
