# fa19-516-153 E.Cloudmesh.Common.3

from cloudmesh.common.FlatDict import FlatDict
from cloudmesh.common.debug import VERBOSE

data = {'hello': 'dictionary'}
data['hello2'] = {
    'tester': 'test'
}

VERBOSE(data)

flat = FlatDict(data)
VERBOSE(flat)