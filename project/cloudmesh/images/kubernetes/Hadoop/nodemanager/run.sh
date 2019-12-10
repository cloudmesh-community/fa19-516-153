#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nodemanager/run.sh

#!/bin/bash

$HADOOP_PREFIX/bin/yarn --config $HADOOP_CONF_DIR nodemanager
