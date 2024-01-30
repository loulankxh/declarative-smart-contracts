#!/bin/bash

dlDir="./benchmarks"
planDir="./view-materialization/fullArithmetic"
outDir="./solidity/fullArithmetic"

for file in "$dlDir"/*.dl; do
	filename=$(basename -- "$file")
	basename="${filename%.*}"
	mkdir -p "$outDir/$basename"
	sbt "run compile --materialize $planDir/$basename.csv --out $outDir/ $dlDir/$filename"
done