#!/bin/bash

set -e

echo "🔄 Starting code generation..."
echo ""

cd "$(dirname "$0")"

echo "🧹 Step 1/5: Cleaning up old mock files..."
rm -rf ../Tests/NearJsonRpcTypesTests/Mock/*
rm -rf ../Tests/NearJsonRpcClientTests/Mock/*
echo "✅ Mock folders cleaned"
echo ""

echo "📝 Step 2/5: Generating Swift types and methods..."
python3 generate_types.py
echo "✅ Types.swift and Methods.swift generated"
echo ""

echo "📝 Step 3/5: Generating mock JSON data..."
python3 generate_mock.py
echo "✅ Mock JSON files generated"
echo ""

echo "📝 Step 4/5: Generating test files..."
python3 generate_tests.py
echo "✅ All test files generated"
echo ""

echo "📝 Step 5/5: Formatting Swift code..."
cd ..
if command -v swiftformat &> /dev/null; then
    swiftformat Sources/ Tests/ Examples/
    echo "✅ Swift code formatted"
else
    echo "⚠️  swiftformat not installed, skipping code formatting"
    echo "   Install with: brew install swiftformat"
fi
