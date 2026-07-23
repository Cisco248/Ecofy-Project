#!/bin/bash
# ==========================================
# GOV_APP DEV RUNNER [ LINUX/MAC ]
# ==========================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ==========================================
# FUNCTIONS
# ==========================================

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

read_value() {
    read -p "$2: " $1
    echo -e "${GREEN}[INFO]${NC} You Choosed: $1"
}

# ==========================================
# CONFIGURATION
# ==========================================

APP_DIR="wms_app"
SERVER_DIR="server"
SERVER_MAIN="main.py"
SERVER_PORT=8000

# ==========================================
# CHECK DIRECTORIES
# ==========================================

if [ ! -d "$SERVER_DIR" ]; then
    print_error "Server directory not found: $SERVER_DIR"
    exit 1
fi

if [ ! -d "$APP_DIR" ]; then
    print_error "App directory not found: $APP_DIR"
    exit 1
fi

# ==========================================
# START SERVER
# ==========================================

print_info "START SERVER FROM PORT 8000"
cd "$SERVER_DIR"

# Start FastAPI server in background
print_info "Python Starting..."
uvicorn ${SERVER_MAIN%.py}:app --reload --host 0.0.0.0 --port $SERVER_PORT &
FASTAPI_PID=$!

print_info "FastAPI running at http://localhost:$SERVER_PORT"

# Wait for server to initialize
sleep 10

# Check if FastAPI is still running
if ! ps -p $FASTAPI_PID > /dev/null 2>&1; then
    print_error "FastAPI failed to start"
    kill $FASTAPI_PID
    exit 1
fi

# Step back direction
cd ..

# ==========================================
# START APPLICATION
# ==========================================

print_info "START APPLICATION"
cd "$APP_DIR"

# Launch the android imulator
EMULATORS=$(flutter emulators)

# Check the emulators for application
if [ -z "$EMULATORS" ]; then
    print_warning "No emulator found, Try again now!"
    kill $FLUTTER_PID
else 
    print_info "$EMULATORS" 
    read_value EMULATOR "Enter Emulator ID"
    flutter emulators --launch $EMULATOR &
    FLUTTER_PID=$!
fi

sleep 10

# Get first available device
DEVICES=$(flutter devices)

if [ -z "$DEVICES" ]; then
    print_warning "No device detected."
    kill $FLUTTER_PID
else
    print_info "$DEVICES" 
    read_value DEVICE "Enter Device Name"
    print_info "Flutter Starting..."
    flutter run -d "$DEVICE" -v --hot &
    FLUTTER_PID=$!
fi

print_info "Both services started."

# ==========================================
# WAIT FOREVER
# ==========================================

# Selection menu for more option
echo "1. Press 'r' → Hot reload"
echo "2. Press 'R' → Hot restart"
echo "3. Press 'q' or Ctrl+C → Quit"

while true; do
sleep 5

# Check if processes are still running
if ! ps -p $FASTAPI_PID > /dev/null 2>&1; then
    print_error "FastAPI server has stopped unexpectedly"
    exit 1
fi

if ! ps -p $FLUTTER_PID > /dev/null 2>&1; then
    print_error "Flutter app has stopped unexpectedly"
    exit 1
fi
done
