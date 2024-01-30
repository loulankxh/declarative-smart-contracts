#!/bin/bash

dlDir="./benchmarks"
planDir="./view-materialization/min-set"
outDir="./solidity/noProjection"

for file in "$dlDir"/*.dl; do
	filename=$(basename -- "$file")
	basename="${filename%.*}"
	mkdir -p "$outDir/$basename"
	sbt "run compile --materialize $planDir/$basename.csv --no-projection --out $outDir/ $dlDir/$filename"
done