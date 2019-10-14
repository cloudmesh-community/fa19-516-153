FROM ubuntu:18.04
# ubuntu slim

WORKDIR ~

RUN apt-get update \
    && apt-get install -y python3 python3-pip git-core \
	&& update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 \
	&& update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1

ENV PATH usr/local/bin:$PATH

RUN mkdir build
COPY requirements.txt build/requirements.txt
RUN pip3 install -r build/requirements.txt

# HACK pass in random string to upgrade argument in order to start from that place (update packages)
ARG CLOUDMESH_UPGRADE=null
RUN cloudmesh-installer git clone storage \
	&& cloudmesh-installer install storage -e

#RUN cms admin mongo install 

ARG CLUSTER_UPGRADE=null
COPY ./cloudmesh/images/cloudmesh/cloudmesh.yaml .cloudmesh/cloudmesh.yaml
COPY . cloudmesh-cluster/.
RUN pip install -e cloudmesh-cluster/.

COPY ./cloudmesh/images/cloudmesh/docker-entrypoint.sh docker-entrypoint.sh
#COPY ~/.ssh/cloudmesh ~/.ssh/id_rsa.pub
RUN chmod +x docker-entrypoint.sh
#ENTRYPOINT [ "./docker-entrypoint.sh" ]