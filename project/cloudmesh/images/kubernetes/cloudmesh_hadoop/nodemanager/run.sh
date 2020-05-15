#!/bin/bash

#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nodemanager/run.sh

$HADOOP_HOME/bin/yarn --config $HADOOP_CONF_DIR nodemanager
