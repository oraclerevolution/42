import os
import re
import subprocess 
import shutil
files = [os.path._getfullpathname(x) for x in os.listdir(".") if not re.match(".*\.py", os.path.basename(x)) and not re.match(".*\.jpg", os.path.basename(x)) and not os.path.isdir(x)]
count = 0
for file in files:
	print(file)
	os.rename(file, "%.2d.jpg" % (count))
	count += 1