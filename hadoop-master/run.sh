#!/bin/bash

# Master script:
if [ ! -f "/.initialized-master" ]; then
	hdfs namenode -format
	echo "First time running, namenode directory formatted"

	# Set initialization flag
	touch "/.initialized-master"
	echo "Hadoop master initialization flag" >> /.initialized-master
fi

# Start namenode
hdfs namenode
