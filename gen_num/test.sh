RANGE=`strings /dev/urandom | grep -o "[A-Z a-z 1-9]" | head -$1 | xargs echo | sed s/' '//g`
echo $RANGE
