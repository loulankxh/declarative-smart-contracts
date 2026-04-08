#!/bin/bash

dlDir="./benchmarks"
planDir="./view-materialization/full-set"
outDir="./solidity/noOptimization"
benchmarks=("dai" "mkr" "uni" "pepe" "erc721" "erc1155" "bayc" "ppg" "uniswapFactory" "uniswapPair" "cryptoPunks")

for basename in "${benchmarks[@]}"; do
	file="$dlDir/$basename.dl"
	mkdir -p "$outDir/$basename"
	sbt "run compile --materialize $planDir/$basename.csv --no-arithmetic-optimization --out $outDir/ $file"
done
