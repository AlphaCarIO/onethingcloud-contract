#!/bin/bash

FOLDER=test

TMP_CMD=

if [ -n "$1" ]; then
    FOLDER=$1
fi

VER=v1

if [ -n "$2" ]; then
    VER=$2
fi

echo 'VER:'$VER

#if [ xt == x"$2" ]; then
#    TMP_CMD=--insecure-skip-tls-verify=true
#fi

if [ "prod" == "$FOLDER" ]; then
  echo 'set-context acar-credit-prod...'
  kubectl config use-context acar-credit-prod
  kubectl config use-context alphacar
else
  echo 'set-context acar-test-env...'
  kubectl config use-context acar-test-env
  kubectl $TMP_CMD delete -f $VER/server-wallet.yaml
  kubectl $TMP_CMD delete -f $VER/server-wallet-pay.yaml
  #kubectl config use-context eos-dapp
fi

kubectl config current-context

if [ xu == x"$3" ]; then
  ./update_envs.sh $FOLDER $VER
  ./update_envs_pay.sh $FOLDER $VER
fi

kubectl $TMP_CMD apply -f $VER/server-wallet.yaml
kubectl $TMP_CMD apply -f $VER/server-wallet-pay.yaml

cd ..
