#!/bin/bash
# regenerate_all.sh
# Complete regeneration script for NEAR Swift SDK

set -e  # Exit on error

echo "🔄 Starting complete regeneration..."
echo ""

# Navigate to scripts directory
cd "$(dirname "$0")"

echo "📝 Step 1/3: Generating Swift types and methods..."
python3 generate_types.py
echo "✅ Types.swift and Methods.swift generated"
echo ""

echo "📝 Step 2/3: Generating mock JSON data..."
python3 generate_mock.py
echo "✅ Mock JSON files generated"
echo ""

echo "📝 Step 3/3: Generating test files..."
python3 generate_tests.py
echo "✅ All test files generated"
