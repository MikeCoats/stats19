#!/bin/bash

set -euo pipefail

BASE_URL="https://data.dft.gov.uk/road-accidents-safety-data/dft-road-casualty-statistics"

echo "Downloading metadata..."
curl --silent \
	"${BASE_URL}-road-safety-open-dataset-data-guide-2022.xlsx" \
	>"./tmp/metadata.xlsx"

for year in $(seq 2018 2022); do
	for table in collision vehicle casualty; do
		echo "Downloading ${year} ${table} data..."
		curl --silent \
			"${BASE_URL}-${table}-${year}.csv" \
			>"./tmp/${table}-${year}.csv"
	done
done
