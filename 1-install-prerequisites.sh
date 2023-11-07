#!/bin/bash

set -euo pipefail

sudo apt install \
	curl \
	python3 \
	python3-pip \
	python3-venv \
	sqlite3

python -mvenv venv
source ./venv/bin/activate
pip install xlsx2csv
