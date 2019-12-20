#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/resourcemanager/Dockerfile 

FROM bde2020/hadoop-base

HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8088

CMD ["/run.sh"]
