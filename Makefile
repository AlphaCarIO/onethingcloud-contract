#####
##Makefile for AlphaCar OTC contract
#####

.PHONY : prepare cc
.IGNORE : prepare cc

SOLC_OPT=--pretty-json --abi --bin --optimize --optimize-runs 200

prepare:
	npm i -g truffle
	npm i -g truffle-flattener
	npm i -g solc
	npm i

cc:
	rm -rf build
	mkdir -p build
	truffle compile
	truffle-flattener contracts/OrderManager.sol > build/OrderManager.sol

	solcjs -o build/OrderManager $(SOLC_OPT) build/OrderManager.sol
	OTC_SECRET=$(OTC_SECRET) node tools/gen_deploy_body.js

t:
	truffle test

ubuntu_get_geth:
	sudo apt-get install software-properties-common
	sudo add-apt-repository -y ppa:ethereum/ethereum
	sudo apt-get update
	sudo apt-get install ethereum
