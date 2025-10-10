#!/bin/bash

# Web3 Privacy Research Portal - Server Startup Script

PORT=${1:-8080}
HOST=${2:-0.0.0.0}

echo "🔐 Starting Web3 Privacy Research Portal..."
echo "📡 Server will be available at: http://localhost:$PORT/ethereum-cypherpunk-research/"
echo "🧪 Test page at: http://localhost:$PORT/ethereum-cypherpunk-research/test.html"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Navigate to parent directory to serve both the app and data files
cd "$(dirname "$0")/.."

# Start the Python HTTP server
python3 -m http.server $PORT --bind $HOST