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

RUN cloudmesh-installer git clone cms \
    && cloudmesh-installer cms -e \
	&& cloudmesh-installer git clone cloud \
	&& cloudmesh-installer install cloud -e \
	&& cloudmesh-installer git clone storage \
	&& cloudmesh-installer install storage -e

# RUN cms admin mongo install \
#	&& 