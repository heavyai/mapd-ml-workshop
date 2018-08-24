#!/usr/bin/env bash

set -e

cd /mapd-ml-cpu/examples
source activate $MAPD_ML
jupyter notebook --allow-root --ip=*
