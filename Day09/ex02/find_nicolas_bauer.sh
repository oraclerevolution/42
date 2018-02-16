grep -i -E "nicolas\tbauer" contacts_hard | perl -lne 'print $1 if /((1-)?((\([0-9]+\))|([0-9]+[\.-]{1}))[0-9]+[\.-]{1}[0-9]+)/'
