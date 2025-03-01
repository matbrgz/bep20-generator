#!/usr/bin/env bash

if [ ! -n "$(command -v dot)" ] then
  printf "\n [ ERROR ] Command dot (graphviz) isn't instaled. Please install graphviz."
  kill $$
fi

for contract in "HelloBEP20" "SimpleBEP20" "StandardBEP20" "BurnableBEP20" "MintableBEP20" "CommonBEP20" "UnlimitedBEP20" "AmazingBEP20" "ServiceReceiver"
do
  npx surya inheritance dist/$contract.dist.sol | dot -Tpng > analysis/inheritance-tree/$contract.png

  npx surya graph dist/$contract.dist.sol | dot -Tpng > analysis/control-flow/$contract.png

  npx surya mdreport analysis/description-table/$contract.md dist/$contract.dist.sol

  npx sol2uml dist/$contract.dist.sol -o analysis/uml/$contract.svg
done
