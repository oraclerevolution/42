grep -i -E "nicolas\tbauer" annuaire.txt | perl -lne 'print $1 if /((1-)?((\([0-9]+\))|([0-9]+[\.-]{1}))[0-9]+[\.-]{1}[0-9]+)/'
