#!/bin/bash

dlDir="./benchmarks"
planDir="./view-materialization/fullNoArithmetic"
outDir="./solidity/noOptimization"

for file in "$dlDir"/*.dl; do
	filename=$(basename -- "$file")
	basename="${filename%.*}"
	mkdir -p "$outDir/$basename"
	sbt "run compile --materialize $planDir/$basename.csv --no-arithmetic-optimization --no-projection --out $outDir/ $dlDir/$filename"
done