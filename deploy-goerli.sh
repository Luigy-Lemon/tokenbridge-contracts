#!/usr/bin/env bash
source .env
JSON_OUTPUT=$(forge create --rpc-url=$RPC_GOERLI --mnemonic="$MNEMONIC" --json --optimize XDaiForeignBridge)

DEPLOYED_TO=$(jq -r '.deployedTo' <<< "$JSON_OUTPUT")

forge verify-contract --watch --chain goerli $DEPLOYED_TO XDaiForeignBridge

# Update the NEW_IMPLEMENTATION variable in the .env file with the value of DEPLOYED_TO 
# Requires .env and variable to already be declared!
sed -i "s/^NEW_IMPLEMENTATION=.*/NEW_IMPLEMENTATION=$DEPLOYED_TO/" .env