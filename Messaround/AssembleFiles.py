import os
import re
import subprocess 
import shutil
if not os.path.exists('output'):
	os.mkdir('output')
files = [os.path._getfullpathname(x) for x in os.listdir(".") if re.match(".*\.jpg", os.path.basename(x))]
for file in files:
	print(os.path.basename((file)))
	filepathx = 'output/' + os.path.basename((file))[:-4]
	if os.path.exists(filepathx):
		shutil.rmtree(filepathx)
	os.mkdir(filepathx)
	y = 0
	count = 0
	while y < 4:
		x = 0
		while x < 4:
			subprocess.call(['ffmpeg', '-i', os.path.basename((file)), '-qscale:v', '2', '-vf', 'crop=200:312:' + str(x * 200) + ':' + str(y * 312), filepathx + '/%.2d.png' % (count) ])
			x += 1
			count += 1
		y += 1
	y = 0
	count = 0
	while y < 4:
		x = 0
		while (x < 4):
			subprocess.call(['ffmpeg', '-i', filepathx + '/%.2d.png' % (count), '-i', filepathx + '/%.2d.png' % (count + 1), '-qscale:v', '2', '-filter_complex', 'vstack', filepathx + '/column-'+ str(y) + "-" + str(x) + '.png'])
			count += 2
			x += 2
		subprocess.call(['ffmpeg', '-i', filepathx + '/column-'+ str(y) + '-0.png', '-i', filepathx + '/column-'+ str(y) + '-2.png', '-qscale:v', '2', '-filter_complex', 'vstack', filepathx + '/column-'+ str(y) + '.png'])
		y += 1
	y = 0
	while y < 4:
		subprocess.call(['ffmpeg', '-i', filepathx + '/column-'+ str(y) + '.png', '-i', filepathx + '/column-'+ str(y + 1) + '.png', '-qscale:v', '2', '-filter_complex', 'hstack', filepathx + '/part-'+ str(y) + '.png'])
		y += 2
	if os.path.isfile(filepathx + '.jpg'):
		os.remove(filepathx + '.jpg')
	subprocess.call(['ffmpeg', '-i', filepathx + '/part-0.png', '-i', filepathx + '/part-2.png', '-qscale:v', '2', '-filter_complex', 'hstack', filepathx + '.jpg'])
	shutil.rmtree(filepathx)