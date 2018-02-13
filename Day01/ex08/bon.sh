ldapsearch -Q "(sn=*bon*)" 1.1 | grep "dn:" | wc -l | tr -d ' '
