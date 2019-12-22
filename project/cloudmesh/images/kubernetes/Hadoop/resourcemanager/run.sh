#!/bin/bash

#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/resourcemanager/run.sh

$HADOOP_PREFIX/bin/yarn --config $HADOOP_CONF_DIR resourcemanager
