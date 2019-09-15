# fa19-516-153 E.Cloudmesh.Common.5

from cloudmesh.common.StopWatch import StopWatch
import time

watch = StopWatch()
watch.start("test")
time.sleep(1.0238427348)


watch.stop("test")

print(watch.get("test"))