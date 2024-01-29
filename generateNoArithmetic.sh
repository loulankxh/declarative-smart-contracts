#!/bin/bash

dlDir="./benchmarks"
planDir="./view-materialization/min-noArithmetic"
outDir="./solidity/min-noArithmetic"

for file in "$dlDir"/*.dl; do
	filename=$(basename -- "$file")
	basename="${filename%.*}"
	mkdir -p "$outDir/$basename"
	sbt "run compile --materialize $planDir/$basename.csv --no-arithmetic-optimization --out $outDir/ $dlDir/$filename"
done