FROM debian:jessie-slim
FROM debian:sid

ENV DEBIAN_FRONTEND = noninteractive

#RUN dpkg-reconfigure debconf

FROM ubuntu

RUN apt-get update 
	
RUN	apt-get install --fix-missing -y software-properties-common 

RUN	add-apt-repository ppa:openjdk-r/ppa 
	
RUN apt-get update 

RUN apt-get install --fix-missing -y -f openjdk-8-jre

#RUN apt-get update \
	#&& apt-get install -y apt-utils build-essential curl tar gnupg \
	#&& apt-get install -y --no-install-recommends apt-utils \
	#&& apt-get install -y -q \
	#&& apt-get install -y openjdk-7-jre openjdk-7-jdk 
	
# Stable hadoop install
ENV HADOOP_VERSION 3.2.1
#ENV HADOOP_VERSION 2.7.5

ENV HADOOP_URL https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
# for old versions ENV HADOOP_URL https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz

RUN set -x 

RUN apt-get update 

RUN apt-get install curl -y

RUN curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz 

RUN curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc 

RUN apt-get install -y wget

RUN wget -O /tmp/KEYS https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import /tmp/KEYS

#RUN wget -q -O /tmp/hadoop.tar.gz http://apache.mirror.digitalpacific.com.au/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz  

#RUN wget -O /tmp/hadoop.asc https://dist.apache.org/repos/dist/release/hadoop/common/hadoop-$HADOOP_VER/hadoop-$HADOOP_VER.tar.gz.asc 

RUN gpg --verify /tmp/hadoop.tar.gz.asc 

RUN tar -xvf /tmp/hadoop.tar.gz -C /opt/ 

RUN rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

COPY "./mapred-site.xml" /etc/hadoop/mapred-site.xml

#RUN cp "./mapred-site.xml" /etc/hadoop/mapred-site.xml 

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs \

RUN mkdir /hadoop-data

ENV HADOOP_PREFIX=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH $HADOOP_PREFIX/bin/:$PATH

WORKDIR /root
COPY entrypoint.sh ./entrypoint.sh
RUN chmod a+x ./entrypoint.sh

RUN apt-get install dos2unix

RUN dos2unix ./entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./entrypoint.sh"] 