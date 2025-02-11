#!/bin/bash

# This script kills a random pod inside factorycube-server ever 0-256 seconds

while :
do

    pods=$(kubectl get pods --no-headers -o custom-columns=":metadata.name" --namespace factorycube-server)

    SAVEIFS=$IFS
    IFS=$'\n'
    pods=($pods)
    IFS=$SAVEIFS

    now=$(date)

    size=${#pods[@]}
    index=$(($RANDOM % $size))
    echo [$now] ${pods[$index]}

    kubectl delete pods ${pods[$index]} --grace-period=0 --force --namespace factorycube-server  > /dev/null 2>&1

    sleep $(( $RANDOM % 256 ))
done