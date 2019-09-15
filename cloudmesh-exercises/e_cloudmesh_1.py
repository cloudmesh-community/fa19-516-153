# fa19-516-153 E.Cloudmesh.Common.1

from cloudmesh.common.util import banner, HEADING
from cloudmesh.common.debug import VERBOSE

"""
from cloudmesh.common.variables import Variables
Check ./__main__.py
variables = Variables()
variables['debug'] = True
variables['trace'] = True
variables['verbose'] = 10
"""

banner("hello world")

class test:
    def exec(self):
        HEADING()
        print("heading")


test = test()
test.exec()

d = {'hello': 'dictionary'}
VERBOSE(d)