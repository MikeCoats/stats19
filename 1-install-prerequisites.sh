#!/bin/bash

set -euo pipefail

sudo apt install \
	curl \
	python3 \
	python3-pip \
	sqlite3

pip install xlsx2csv
