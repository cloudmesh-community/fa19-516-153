# -*- coding: utf-8 -*-
"""
Created on Sun Oct 13 00:48:58 2019

@author: Siddhesh
"""

import libcloud
from libcloud.compute.types import Provider 
from libcloud.compute.providers	import get_driver 
from cloudmesh.common.util import path_expand 
from cloudmesh.management.configuration.config import Config 
from pprint	import pprint

name="aws"
credentials	= Config()["cloudmesh"]["cloud"][name]["credentials"]