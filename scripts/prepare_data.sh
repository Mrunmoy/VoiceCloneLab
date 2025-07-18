#!/bin/bash

# This script prepares dataset metadata by running a Python helper script inside a virtual environment.
# It must be run from the project root like: ./scripts/prepare_data.sh

# Get the absolute path to the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
VENV_PATH="$PROJECT_ROOT/venv"
PREPARE_DATA_SCRIPT="$SCRIPT_DIR/prepare_data.py"

echo "--- Preparing Dataset Metadata ---"
echo "Script location: $SCRIPT_DIR"
echo "Project root: $PROJECT_ROOT"
cd "$PROJECT_ROOT" || { echo "Error: Could not navigate to project root. Exiting."; exit 1; }

# Check if the Python script exists
if [ ! -f "$PREPARE_DATA_SCRIPT" ]; then
    echo "Error: Python script not found at $PREPARE_DATA_SCRIPT"
    exit 1
fi

# Check and activate virtual environment
if [ ! -f "$VENV_PATH/bin/activate" ]; then
    echo "Error: Virtual environment not found at $VENV_PATH"
    echo "Please run setup_env.sh first."
    exit 1
fi

echo "Activating virtual environment..."
# shellcheck source=/dev/null
source "$VENV_PATH/bin/activate" || {
    echo "Error: Could not activate virtual environment. Exiting."
    exit 1
}
echo "Virtual environment activated."

# Run the metadata generator
echo "Running: $PREPARE_DATA_SCRIPT"
python "$PREPARE_DATA_SCRIPT"
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "Error: Data preparation failed (exit code $EXIT_CODE)."
    deactivate
    exit 1
fi

echo ""
echo "--- Data Preparation Complete ---"
echo "metadata.csv has been generated."
echo "To exit the virtual environment: deactivate"
