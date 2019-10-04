FROM ubuntu:18.04
# ubuntu slim

RUN apt-get update \
    && apt-get install -y python3 pip

RUN pip install cloudmesh-installer \
    && cloudmesh-installer git clone cms \
    && cloudmesh-installer cms -e

