#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RESULTS_DIR="${SCRIPT_DIR}/results"

# Create results directory
mkdir -p "$RESULTS_DIR"

# Set Python path
export PYTHONPATH=$PYTHONPATH:$SCRIPT_DIR

# Run tests with timestamp in the output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
robot --outputdir "${RESULTS_DIR}/${TIMESTAMP}" tests/test_cases/registration_tests.robot 