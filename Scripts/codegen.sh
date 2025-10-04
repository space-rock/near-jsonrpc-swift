#!/bin/bash

set -e

echo "🔄 Starting code generation..."
echo ""

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
echo ""

echo "📝 Step 4/4: Formatting Swift code..."
cd ..
if command -v swiftformat &> /dev/null; then
    swiftformat Sources/ Tests/ Examples/
    echo "✅ Swift code formatted"
else
    echo "⚠️  swiftformat not installed, skipping code formatting"
    echo "   Install with: brew install swiftformat"
fi
