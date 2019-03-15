#!/bin/bash

FOLDER=test

TMP_CMD=

NS='--namespace onethingcloud'

if [ -n "$1" ]; then
    FOLDER=$1
fi

if [ xt == x"$2" ]; then
    TMP_CMD=--insecure-skip-tls-verify=true
fi

echo '---> NS:'$NS

if [ "prod" == "$FOLDER" ]; then
  echo 'set-context acar-credit-prod...'
  kubectl config use-context acar-credit-prod
else
  echo 'set-context acar-test-env...'
  kubectl config use-context acar-test-env
fi

cd ./envs/$FOLDER/

kubectl $TMP_CMD delete configmap wallet.conf $NS
kubectl $TMP_CMD create configmap wallet.conf \
  --from-file=wallet.conf=wallet.conf $NS

kubectl $TMP_CMD delete secret passwd.json $NS
kubectl $TMP_CMD create secret generic \
  --from-file=passwd.json=passwd.json passwd.json $NS

kubectl $TMP_CMD delete secret private-key $NS
kubectl $TMP_CMD create secret generic \
  --from-file=private_key=private_key private-key $NS
