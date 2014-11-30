#!/bin/bash
ID=$(id -u)
if [[ ! $ID -eq 0 ]]
then
	echo "You must exec use root! Stopped!"
	exit 1
fi
HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}
HBASE_HOME=${HBASE_HOME:-/opt/hbase}
HIVE_HOME=${HIVE_HOME:-/opt/hive}
HCATALOG_HOME=${HCATALOG_HOME:-$HIVE_HOME/hcatalog}
SPARK_HOME=/opt/spark
# starting hadoop
if [[ -d "$HADOOP_HOME" ]]
then
	starting hadoop...
	if ! $HADOOP_HOME/sbin/start-dfs.sh
	then
		echo "Failed to start hdfs..., stopped!"
		exit 1
	else
		echo "Succeed to start hdfs!"
	fi
	if ! $HADOOP_HOME/sbin/start-yarn.sh
	then
		echo "Failed to start yarn..., stopped!"
		exit 1
	else
		echo "Succeed to start yarn!"
	fi
fi
# starting hbase
if [[ -d "$HBASE_HOME" ]]
then
	starting hbase...
	if $HBASE_HOME/bin/start-hbase.sh
	then
		echo "Succeed to start hbase!"
	else
		echo "Failed to start hbase!"
	fi
fi
# staring hive
if [[ -d "$HIVE_HOME" ]]
then
	starting hive...
	echo "Succed to start hive!"
fi
# staring hcatalog
if [[ -d "$HCATALOG_HOME" ]]
then
	starting hcatalog...
	if $HCATALOG_HOME/sbin/hcat_server.sh
	then
		echo "Succeed to start hcat!"
	else
		echo "Failed to start hcat!"
	fi
	if $HCATALOG_HOME/sbin/webhcat_server.sh
	then
		echo "Succeed to start webhcat!"
	else
		echo "Failed to start webhcat!"
	fi
fi
# spark
if [[ -d "$SPARK_HOME" ]]
	starting spark master...
	if $SPARK_HOME/sbin/start-master.sh
	then
		echo "Succed to start spark master"
	else
		echo "Failed to start spark master"
	fi
	$SPARKHOME/bin/spark-class org.apache.spark.deploy.worker.Worker spark://lenovo:8080
fi

