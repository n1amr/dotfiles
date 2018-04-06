#!/bin/bash

echo 'Play'
while true; do
    env | grep BLOCK >> ~/log
    # echo "button = $BLOCK_BUTTON, INSTANCE = $BLOCK_INSTANCE"
    echo 'Play'
    sleep 0.5
done

exit

echo 'start' >> ~/log
env | grep BLOCK >> ~/log
while true; do
    echo 'update' >> ~/log
    echo "button = $BLOCK_BUTTON, INSTANCE = $BLOCK_INSTANCE"
    sleep 4
done
echo 'finish' >> ~/log
