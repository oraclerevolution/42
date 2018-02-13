for f in *.m3u8; do
sed 's/ /%20/g' "$f"| sed -e "s/\\\\Musiques/http:\/\/82.124.119.230/" | tr "\\" "\/" | sed -e '/#EXT/ s/%20/ /g' | sed 's/D:http/http/g' > "out/$f"
done
