#!/bin/bash

# This script sets up the Python virtual environment and installs all dependencies,
# including adding Coqui TTS as a git submodule.

# Define the root project directory name
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
VENV_NAME="venv"
VENV_PATH="$PROJECT_ROOT/$VENV_NAME"
REQUIREMENTS_FILE="$PROJECT_ROOT/requirements.txt"
COQUI_TTS_PATH=TTS

echo "--- Setting up Voice Cloning Project Environment ---"
echo "Navigating to project root: $PROJECT_ROOT"
cd "$PROJECT_ROOT" || { echo "Error: Could not navigate to project root. Exiting."; exit 1; }

# --- Check Python version ---
PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info.major)')
PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info.minor)')
if [ "$PYTHON_MAJOR" -ne 3 ] || [ "$PYTHON_MINOR" -lt 8 ]; then
    echo "Error: Python 3.8 or higher is required. Exiting."
    exit 1
fi

# --- Check python3-venv availability ---
python3 -m venv --help > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Error: python3-venv is not available. Please install it (e.g., sudo apt install python3-venv)."
    exit 1
fi

# --- Add Coqui TTS as a Git Submodule ---
echo ""
echo "--- Step 1: Ensuring Coqui TTS Submodule is Added Properly ---"

# Ensure this is a git repo
if [ ! -d ".git" ]; then
    echo "This directory is not a Git repository. Initializing Git..."
    git init || { echo "Error: Failed to initialize git repo. Exiting."; exit 1; }
fi

# Check if submodule already exists
if git config --file .gitmodules --get-regexp path 2>/dev/null | grep -q "^submodule\.TTS\.path"; then
    echo "Found existing submodule entry for TTS. Skipping add."
else
    if [ -d "$COQUI_TTS_PATH" ]; then
        echo "Error: Directory 'TTS' already exists but is not a registered submodule."
        echo "Please remove it manually and re-run this script:"
        echo "    rm -rf TTS"
        echo "    git rm --cached TTS"
        echo "    rm -rf .git/modules/TTS"
        echo "    sed -i '/TTS/d' .gitmodules"
        exit 1
    fi

    echo "Adding Coqui TTS as a git submodule..."
    git submodule add https://github.com/coqui-ai/TTS.git "$COQUI_TTS_PATH" || {
        echo "Error: Failed to add Coqui TTS submodule. Exiting."
        exit 1
    }

    git add .gitmodules TTS
    sleep 1
fi

echo "Initializing and updating submodule..."
git submodule update --init --recursive || {
    echo "Error: Failed to initialize submodules. Exiting."
    exit 1
}

# --- Create and Activate Virtual Environment ---
echo ""
echo "--- Step 2: Setting up Python Virtual Environment ---"
if [ ! -d "$VENV_PATH" ]; then
    echo "Creating virtual environment at '$VENV_PATH'..."
    python3 -m venv "$VENV_PATH" || { echo "Error: Failed to create virtual environment. Exiting."; exit 1; }
else
    echo "Virtual environment already exists at '$VENV_PATH'."
fi

echo "Activating virtual environment..."
# shellcheck source=/dev/null
source "$VENV_PATH/bin/activate" || { echo "Error: Could not activate virtual environment. Exiting."; exit 1; }

# --- Install Requirements ---
echo ""
echo "--- Step 3: Installing Python Dependencies ---"
if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "Error: Requirements file not found at '$REQUIREMENTS_FILE'. Exiting."
    exit 1
fi

echo "Installing dependencies from $REQUIREMENTS_FILE..."
pip install -r "$REQUIREMENTS_FILE" || { echo "Error: Failed to install dependencies. Exiting."; exit 1; }

echo "Installing Coqui TTS in editable mode..."
pip install -e "$COQUI_TTS_PATH/" || { echo "Error: Failed to install Coqui TTS. Exiting."; exit 1; }

echo ""
echo "--- Environment Setup Complete ---"
echo "You can now proceed with dataset preparation and training."
