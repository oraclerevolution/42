ldapsearch -Q -S "cn" "(uid=z*)"| grep "cn:" | sort -r -f | cut -c5-
