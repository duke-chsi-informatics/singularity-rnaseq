#!/bin/bash

set -u
SINGULARITY_DIR="$HOME/container_images"


SINGULARITY_CACHEDIR="${SINGULARITY_CACHEDIR:-$SINGULARITY_DIR/cachedir}"
export SINGULARITY_CACHEDIR
SINGULARITY_PULLFOLDER="${SINGULARITY_PULLFOLDER:-$SINGULARITY_DIR/pulldir}"
export SINGULARITY_PULLFOLDER

SINGULARITY_IMAGE="${1:-library://granek/duke-chsi-informatics/singularity-rnaseq:latest}"

DATA_BASE_DIR="${DATA_BASE_DIR:-$HOME}"
WORKSPACE_BASE_DIR="${WORKSPACE_BASE_DIR:-$HOME}"

DATA="$DATA_BASE_DIR/rawdata"
WORKSPACE="$WORKSPACE_BASE_DIR/workspace"

 

 
if [ -d "${DATA}" ]; then
    # BIND_ARGS="--bind ${DATA}:/data:ro"
    BIND_ARGS="--bind ${DATA}:/data"
else
    echo "Make sure DATA exists: $DATA"
fi

if [ -d "${WORKSPACE}" ]; then
    BIND_ARGS="$BIND_ARGS --bind ${WORKSPACE}:/workspace"
else
    echo "Make sure WORKSPACE exists: $WORKSPACE"
fi

#-----------------
SINGTMP="/tmp/${USER}_`date +%s`_tmp"
mkdir -p $SINGTMP
echo "Binding /tmp to $SINGTMP"

trap "{ rm -rf $SINGTMP; }" EXIT

BIND_ARGS="$BIND_ARGS --bind $SINGTMP:/tmp"
#-----------------

mkdir -p $SINGULARITY_PULLFOLDER $SINGULARITY_CACHEDIR
#--------------------------------------------------------------------------------

singularity run $BIND_ARGS $SINGULARITY_IMAGE


