#!/bin/bash

FOLDER=test

TMP_CMD=

if [ -n "$1" ]; then
    FOLDER=$1
fi

if [ xt == x"$2" ]; then
    TMP_CMD=--insecure-skip-tls-verify=true
fi

if [ "prod" == "$FOLDER" ]; then
  echo 'set-context acar-credit-prod...'
  kubectl config use-context acar-credit-prod
else
  echo 'set-context acar-test-env...'
  #kubectl config use-context acar-test-env
  kubectl config use-context eos-dapp
fi

kubectl config current-context

if [ xu == x"$3" ]; then
  ./update_envs.sh $FOLDER $2
fi

kubectl $TMP_CMD apply -f server-wallet.yaml
