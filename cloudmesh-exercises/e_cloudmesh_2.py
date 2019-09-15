# fa19-516-153 E.Cloudmesh.Common.2

from cloudmesh.common.dotdict import dotdict

data = {'hello': 'dictionary'}
data = dotdict(data)

assert data.hello == data['hello']
