#!/bin/bash

echo $@
echo "~~~~~~~~~~~\n"
# -S is better for FreeTDS then -H
options=$( echo $@ | sed -e 's/-H /-S /' -e 's/ -i.*//' -e 's/-d /-D /' -e 's/-P/-P /' )
# osql/tsql in freetds don't seem to accept a file flag
sql_scratch=$( echo $@ | sed 's|^.* -i||' )
# and execute...
echo $options
echo "#############\n"
cat $sql_scratch | tsql $options
