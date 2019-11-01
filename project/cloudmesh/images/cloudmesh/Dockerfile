FROM ubuntu:19.10
# ubuntu slim

WORKDIR ~

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip git-core wget 
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN pip install pip -U
ENV PATH usr/local/bin:$PATH

RUN pip install cloudmesh-installer
RUN mkdir /cm
WORKDIR /cm
RUN cloudmesh-installer git clone storage
RUN cloudmesh-installer install storage -e
RUN cms help

#COPY requirements.txt build/requirements.txt
# move as volume
#COPY . cloudmesh-cluster/.



#RUN pip install -r build/requirements.txt

#RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - \
#	&& echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
#	&& apt-get update \
#	&& DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-org

# HACK pass in random string to upgrade argument in order to start from that place (update packages)
#ARG CLOUDMESH_UPGRADE=null
#RUN cloudmesh-installer git clone storage
#RUN cloudmesh-installer install storage -e


#RUN cms config set cloudmesh.data.mongo.MONGO_AUTOINSTALL=True
#RUN cms init

#COPY ./cloudmesh/images/cloudmesh/docker-entrypoint.sh docker-entrypoint.sh
#RUN chmod +x docker-entrypoint.sh
#ENTRYPOINT [ "/bin/bash", "docker-entrypoint.sh"]