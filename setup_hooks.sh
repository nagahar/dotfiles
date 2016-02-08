#!/bin/sh
echo "######copy githooks######"
for f in `ls -1 ./githooks`; do
    chmod +x ./githooks/$f
    cp ./githooks/$f .git/hooks/
done
echo "######done copy githooks######"
