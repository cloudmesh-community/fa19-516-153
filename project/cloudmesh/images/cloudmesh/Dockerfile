FROM ubuntu:19.10
# ubuntu slim

WORKDIR /root/

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update \
    && apt-get install -qqy python3 python3-pip git-core wget \
	&& update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
	&& update-alternatives --install /usr/bin/python python /usr/bin/python3 1

ENV PATH usr/local/bin:$PATH

COPY requirements-dev.txt requirements-dev.txt
COPY . cloudmesh-cluster/.

# Upgrade pip to latest, install cloudmesh-installer, and install local project
RUN pip install -r requirements-dev.txt --upgrade

# Install mongo on the server
# RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - \
# 	&& echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list \
# 	&& apt-get -qq update \
# 	&& apt-get install -qqy mongodb-org

# HACK pass in random string to upgrade argument in order to start from that place (update packages)
ARG CLOUDMESH_UPGRADE=null
RUN cloudmesh-installer git clone cloud
RUN cloudmesh-installer install cloud -e

RUN cms config set cloudmesh.data.mongo.MONGO_AUTOINSTALL=True
RUN cms init

COPY ./cloudmesh/images/cloudmesh/docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT "docker-entrypoint.sh"