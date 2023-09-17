#!/bin/bash


CLUSTER_ENV=$1
OPERATION=$2
MODE=$3


if [[ -z "$CLUSTER_ENV" ]]; then
    echo "Must provide CLUSTER_ENV environment variable" 1>&2
    exit 1
fi

if [[ -z "$MODE" ]]; then
    echo "Must provide MODE environment variable" 1>&2
    exit 1
fi

if [[ $MODE != cluster && $MODE != nodegroup ]] ; then
    echo "Invalid MODE. Valid values cluster|nodegroup|addon"
    exit 1
fi


if [[ -z "$OPERATION" ]]; then
    echo "Must provide OPERATION environment variable" 1>&2
    exit 1
fi

if [[ $OPERATION != create && $OPERATION != update ]] ; then
    echo "Invalid OPERATION. Valid values create|update"
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

python3 generate.py

if [[ $MODE == "cluster" ]]; then
    if [[  $OPERATION == "create" ]]; then
        eksctl create cluster -f $CLUSTER_ENV/eks-cluster.yml
    else
       eksctl upgrade cluster -f $CLUSTER_ENV/eks-cluster.yml
    fi
fi


if [[ $MODE == "nodegroup" ]]; then
    if [[  $OPERATION == "create" ]]; then
        eksctl create nodegroup -f $CLUSTER_ENV/eks-cluster.yml
    else
        eksctl upgrade nodegroup -f $CLUSTER_ENV/eks-cluster.yml
    fi
fi

if [[ $MODE == "addon" ]]; then
    if [[  $OPERATION == "create" ]]; then
        eksctl create addon -f $CLUSTER_ENV/eks-cluster.yml
    fi
fi