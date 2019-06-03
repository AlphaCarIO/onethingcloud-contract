#!/bin/bash

FOLDER=test

TMP_CMD=

NS='--namespace onethingcloud'

if [ -n "$1" ]; then
    FOLDER=$1
fi

VER=v1

if [ -n "$2" ]; then
    VER=$2
fi

#if [ xt == x"$2" ]; then
#    TMP_CMD=--insecure-skip-tls-verify=true
#fi

echo '---> NS:'$NS

if [ "prod" == "$FOLDER" ]; then
  echo 'set-context acar-credit-prod...'
  kubectl config use-context acar-credit-prod
  kubectl config use-context alphacar
else
  echo 'set-context acar-test-env...'
  kubectl config use-context acar-test-env
fi

cd ./$VER/envs/$FOLDER/

kubectl $TMP_CMD delete configmap wallet-pay.conf $NS
kubectl $TMP_CMD create configmap wallet-pay.conf \
  --from-file=wallet.conf=wallet-pay.conf $NS

kubectl $TMP_CMD delete secret passwd-pay.json $NS
kubectl $TMP_CMD create secret generic \
  --from-file=passwd.json=passwd-pay.json passwd-pay.json $NS

kubectl $TMP_CMD delete secret private-key-pay $NS
kubectl $TMP_CMD create secret generic \
  --from-file=private_key=private_key-pay private-key-pay $NS
