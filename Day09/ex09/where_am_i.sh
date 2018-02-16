export tst=$(ifconfig | grep inet | cut -d\  -f2 | perl -lne 'print $1 if /(([0-9]+[\.+]){1,4}[0-9]{1,3})/')
if [[ $tst ]]; then
	echo $tst | tr " " "\n"
else
	echo "I am lost!"
fi