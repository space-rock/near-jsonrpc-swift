#!/bin/bash

# Setup script for NEAR RPC Type Verification
# This script sets up a Python virtual environment with required dependencies
# for running the type verification server.

set -e

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPTS_DIR/venv"

echo "🐍 Setting up Python environment for type verification..."
echo "📁 Scripts directory: $SCRIPTS_DIR"

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo "❌ Error: python3 is not installed or not in PATH"
    echo "Please install Python 3.8 or later"
    exit 1
fi

PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
echo "🐍 Found Python $PYTHON_VERSION"

# Check if we have a supported Python version (3.8+)
if ! python3 -c "import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)" 2>/dev/null; then
    echo "❌ Error: Python 3.8 or later is required"
    echo "Found Python $PYTHON_VERSION"
    exit 1
fi

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "📦 Creating Python virtual environment..."
    python3 -m venv "$VENV_DIR"
else
    echo "📦 Virtual environment already exists"
fi

# Activate virtual environment
echo "🔄 Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Upgrade pip
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "📥 Installing Python dependencies..."
pip install -r "$SCRIPTS_DIR/requirements.txt"

echo "✅ Setup complete!"