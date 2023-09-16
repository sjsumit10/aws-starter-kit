#!/bin/bash


CLUSTER_ENV=$1
MODE=$2

if [[ -z "$CLUSTER_ENV" ]]; then
    echo "Must provide CLUSTER_ENV environment variable" 1>&2
    exit 1
fi

if [[ -z "$MODE" ]]; then
    echo "Must provide MODE environment variable" 1>&2
    exit 1
fi

if [[ $MODE != cluster && $MODE != nodegroup ]] ; then
    echo "Invalid MODE. Valid values cluster|nodegroup"
    exit 1
fi


echo $CLUSTER_ENV;
echo $MODE;

if [[ ! -f "$CLUSTER_ENV.env" ]]; then
    echo "$CLUSTER_ENV.env file does not exists"
    exit 1
fi

for line in $(cat ${CLUSTER_ENV}.env | sed '/^#/d' | sed '/^$/d'); do
 export $line;
done
echo "Sourced $CLUSTER_ENV.env file"

env

printf "\nGenerating yaml.."

python3 generate.py cluster

# if [[ $MODE == "cluster" ]]; then
    
# fi


# if [[ $MODE == "nodegroup" ]]; then
    
# fi