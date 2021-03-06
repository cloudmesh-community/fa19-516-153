Documentation
=============

[![image](https://img.shields.io/travis/TankerHQ/cloudmesh-bar.svg?branch=master)](https://travis-ci.org/TankerHQ/cloudmesn-bar)

[![image](https://img.shields.io/pypi/pyversions/cloudmesh-bar.svg)](https://pypi.org/project/cloudmesh-bar)

[![image](https://img.shields.io/pypi/v/cloudmesh-bar.svg)](https://pypi.org/project/cloudmesh-bar/)

[![image](https://img.shields.io/github/license/TankerHQ/python-cloudmesh-bar.svg)](https://github.com/TankerHQ/python-cloudmesh-bar/blob/master/LICENSE)

see cloudmesh.cmd5

* https://github.com/cloudmesh/cloudmesh.cmd5


*Build Cloudmesh*
```sh
docker build -t cloudmesh-image -f ./cloudmesh/images/cloudmesh/Dockerfile .
docker run --name cloudmesh -d cloudmesh-image
```
```sh
winpty docker attach cloudmesh
```
`CTRL-P + CTRL-Q`

```sh
docker build -t cloudmesh-image --build-arg CLOUDMESH_UPGRADE="RANDOMSTRING" -f cloudmesh-cluster/cloudmesh/images/cloudmesh/Dockerfile cloudmesh-cluster/.
```

```sh
docker build -t cloudmesh-image --build-arg cLUSTER_UPGRADE="RANDOMSTRING" -f cloudmesh-cluster/cloudmesh/images/cloudmesh/Dockerfile cloudmesh-cluster/.
```