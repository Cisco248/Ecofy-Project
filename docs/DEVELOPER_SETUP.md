# E-WMS Development Setup Guide

## Complete Development Environment Setup

This guide provides step-by-step instructions for setting up the E-WMS project for development on Windows, macOS, and Linux.

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Prerequisites Installation](#prerequisites-installation)
3. [Backend Setup](#backend-setup)
4. [Mobile Application Setup](#mobile-application-setup)
5. [Database Setup](#database-setup)
6. [Running the Project](#running-the-project)
7. [IDE Configuration](#ide-configuration)
8. [Troubleshooting](#troubleshooting)
9. [Development Workflow](#development-workflow)

---

## System Requirements

### Minimum Requirements

- **RAM**: 8 GB
- **Storage**: 20 GB (10 GB for tools, 10 GB for project)
- **Processor**: Dual-core processor
- **Network**: Stable internet connection

### Recommended Requirements

- **RAM**: 16 GB
- **Storage**: 50 GB SSD
- **Processor**: Quad-core processor or better
- **Network**: Broadband connection (50 Mbps+)

### Supported Operating Systems

- **Windows 10/11** (64-bit)
- **macOS 11+** (Intel or Apple Silicon)
- **Linux** (Ubuntu 20.04+, Fedora 35+, Debian 11+)

---

## Prerequisites Installation

### 1. Install Git

**Windows**:

1. Download Git from [git-scm.com](https://git-scm.com)
2. Run the installer
3. Choose default options or customize as needed
4. Verify: `git --version`

**macOS**:

```bash
# Using Homebrew (if installed)
brew install git

# Or install Xcode Command Line Tools
xcode-select --install

# Verify
git --version
```

**Linux** (Ubuntu/Debian):

```bash
sudo apt-get update
sudo apt-get install git
git --version
```

### 2. Install Docker & Docker Compose

**Windows**:

1. Download [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
2. Run installer and follow on-screen instructions
3. Enable WSL 2 (Windows Subsystem for Linux)
4. Verify:

   ```cmd
   docker --version
   docker-compose --version
   ```

**macOS**:

```bash
# Using Homebrew
brew install docker docker-compose

# Or install Docker Desktop from https://www.docker.com/products/docker-desktop

# Verify
docker --version
docker-compose --version
```

**Linux** (Ubuntu/Debian):

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Verify
docker --version
docker-compose --version
```

### 3. Install Flutter SDK

**Windows**:

1. Download Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Extract to `C:\src\flutter`
3. Add Flutter to PATH:
   - Right-click "This PC" → Properties
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Add `C:\src\flutter\bin` to PATH
4. Verify:

   ```cmd
   flutter --version
   ```

**macOS** (Apple Silicon):

```bash
# Download and extract
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.19.0-stable.zip
unzip flutter_macos_arm64_3.19.0-stable.zip

# Add to PATH
export PATH="$PATH:~/development/flutter/bin"

# Add to ~/.zprofile for persistence
echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.zprofile

# Verify
flutter --version
```

**macOS** (Intel):

```bash
# Download and extract
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_x86_64_3.19.0-stable.zip
unzip flutter_macos_x86_64_3.19.0-stable.zip

# Add to PATH and verify (same as above)
```

**Linux** (Ubuntu/Debian):

```bash
# Install dependencies
sudo apt-get install curl git xz-utils zip libglu1-mesa

# Download and extract
mkdir -p ~/development
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.0-stable.tar.xz
tar -xf flutter_linux_3.19.0-stable.tar.xz

# Add to PATH
export PATH="$PATH:$HOME/development/flutter/bin"
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc

# Verify
flutter --version
```

### 4. Install Python 3.13+

**Windows**:

1. Download Python from [python.org](https://www.python.org/downloads/)
2. Run installer
3. **Important**: Check "Add Python to PATH"
4. Choose "Install Now"
5. Verify:

   ```cmd
   python --version
   pip --version
   ```

**macOS**:

```bash
# Using Homebrew
brew install python@3.13

# Or using pyenv
brew install pyenv
pyenv install 3.13.0
pyenv global 3.13.0

# Verify
python3 --version
pip3 --version
```

**Linux**:

```bash
# Ubuntu/Debian
sudo apt-get install python3.13 python3-pip

# Fedora
sudo dnf install python3.13 python3-pip

# Verify
python3 --version
pip3 --version
```

### 5. Install PostgreSQL (Optional - for local development)

**Windows**:

1. Download from [postgresql.org](https://www.postgresql.org/download/windows/)
2. Run installer
3. Set password for postgres user
4. Use default port 5432
5. Verify: `psql --version`

**macOS**:

```bash
# Using Homebrew
brew install postgresql

# Start PostgreSQL
brew services start postgresql

# Verify
psql --version
```

**Linux**:

```bash
sudo apt-get install postgresql postgresql-contrib
sudo systemctl start postgresql
psql --version
```

### 6. Install Android Studio (For Android Development)

**Windows/macOS/Linux**:

1. Download from [developer.android.com](https://developer.android.com/studio)
2. Run installer and complete setup
3. Install Android SDK (API level 31+)
4. Accept licenses: `flutter doctor --android-licenses`
5. Verify: `flutter doctor`

---

## Backend Setup

### Step 1: Navigate to Server Directory

```bash
cd e_wms_mobile/server
```

### Step 2: Create Python Virtual Environment

**Windows**:

```cmd
# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# You should see (venv) prefix in terminal
```

**macOS/Linux**:

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# You should see (venv) prefix in terminal
```

### Step 3: Install Python Dependencies

```bash
# Upgrade pip
pip install --upgrade pip

# Install all dependencies
pip install -r requirements.txt

# Verify installation
pip list
```

### Step 4: Configure Environment Variables

**Create `.env` file in `server/` directory**:

```env
# Database Configuration
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/fastapi_db

# Server Configuration
DEBUG=true
ENVIRONMENT=development

# JWT Configuration
SECRET_KEY=your-super-secret-key-change-in-production
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# API Configuration
API_HOST=0.0.0.0
API_PORT=8000

# Logging
LOG_LEVEL=INFO
```

### Step 5: Initialize Database

```bash
# Create database tables
# The database will be created automatically on first run,
# or manually if needed:

# Using Python script (if available)
python database/init.py

# Or manually with psql
psql -U postgres -d fastapi_db -f schema.sql
```

### Step 6: Run Backend Server

```bash
# Using Uvicorn directly
uvicorn main:app --reload --host 0.0.0.0 --port 8000

# Or using the app.sh script
bash app.sh
```

**Expected Output**:

```
INFO:     Uvicorn running on http://0.0.0.0:8000
INFO:     Application startup complete
```

**Test the API**:

- API Documentation: [http://localhost:8000/docs](http://localhost:8000/docs)
- ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)
- Health Check: [http://localhost:8000/](http://localhost:8000/)

---

## Mobile Application Setup

### Step 1: Navigate to App Directory

```bash
cd e_wms_mobile/app
```

### Step 2: Get Flutter Dependencies

```bash
# Download and compile dependencies
flutter pub get

# If there are issues, try:
flutter clean
flutter pub get
```

### Step 3: Generate Code (Riverpod & Build Runner)

```bash
# Generate required code files
flutter pub run build_runner build

# For watching changes (development)
flutter pub run build_runner watch

# If you encounter conflicts, use:
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 4: Configure API Endpoint

**Edit the API configuration file** (if exists):

```dart
// lib/utilities/constants/api_constants.dart

class ApiConstants {
  // For local development
  static const String API_BASE_URL = 'http://192.168.1.100:8000';
  
  // Or for emulator (Android)
  // static const String API_BASE_URL = 'http://10.0.2.2:8000';
  
  // Or for simulator (iOS)
  // static const String API_BASE_URL = 'http://localhost:8000';
}
```

**Or update in main.dart/app initialization**:

```dart
// Configure based on platform or build target
const String apiBaseUrl = 'http://YOUR_SERVER_IP:8000';
```

### Step 5: Run on Emulator/Device

**List available devices**:

```bash
flutter devices
```

**Android Emulator**:

```bash
# Start emulator (if not running)
emulator -avd <emulator-name>

# Run app
flutter run -d emulator

# Or specific device
flutter run -d <device-id>
```

**iOS Simulator** (macOS only):

```bash
# Start simulator
open -a Simulator

# Run app
flutter run -d iPhone
```

**Physical Device**:

```bash
# Enable USB debugging on device

# List devices
flutter devices

# Run app
flutter run -d <device-id>
```

### Step 6: Verify App Startup

The app should:

1. Display splash screen
2. Load initial data
3. Navigate to sign-in screen if not authenticated
4. Show dashboard if already signed in

---

## Database Setup

### Using Docker Compose (Recommended)

```bash
# From project root
docker-compose up -d

# View running services
docker-compose ps

# Check logs
docker-compose logs -f db
docker-compose logs -f server

# Stop services
docker-compose down

# Remove volumes (reset database)
docker-compose down -v
```

### Manual PostgreSQL Setup

**Windows**:

```cmd
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE fastapi_db;

# Create user
CREATE USER wms_user WITH PASSWORD 'secure_password';

# Grant privileges
GRANT ALL PRIVILEGES ON DATABASE fastapi_db TO wms_user;

# Exit
\q
```

**macOS/Linux**:

```bash
# Connect to PostgreSQL
sudo -u postgres psql

# Same commands as above
```

### Database Verification

```bash
# Connect to database
psql -U postgres -d fastapi_db

# List tables
\dt

# View users table structure
\d+ users

# Exit
\q
```

---

## Running the Project

### Full Stack (Docker Compose)

```bash
cd e_wms_mobile

# Start all services
docker-compose up -d

# Services will be available at:
# - Backend API: http://localhost:8000
# - PostgreSQL: localhost:5433
```

### Full Stack (Manual)

**Terminal 1 - Backend**:

```bash
cd e_wms_mobile/server
source venv/bin/activate  # or venv\Scripts\activate on Windows
uvicorn main:app --reload
```

**Terminal 2 - Mobile**:

```bash
cd e_wms_mobile/app
flutter run
```

### Verification Checklist

- [ ] Backend server running at `http://localhost:8000`
- [ ] API docs accessible at `http://localhost:8000/docs`
- [ ] Database connected (check logs)
- [ ] Flutter app compiled successfully
- [ ] App displays sign-in screen
- [ ] Can create new user account
- [ ] Can sign in with credentials

---

## IDE Configuration

### Visual Studio Code

**Recommended Extensions**:

1. Flutter
2. Dart
3. Python
4. Pylance
5. Docker
6. PostgreSQL
7. REST Client

**Install Extensions**:

```bash
code --install-extension Dart-Code.flutter
code --install-extension Dart-Code.dart-code
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-vscode.docker
code --install-extension cweijan.vscode-postgresql-client
code --install-extension humao.rest-client
```

**Workspace Settings** (`.vscode/settings.json`):

```json
{
  "dart.devToolsLocation": "side-panel",
  "flutter.debugLogging": true,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "Dart-Code.dart-code",
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },
  "[python]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "ms-python.python",
    "editor.codeActionsOnSave": {
      "source.organizeImports": "explicit"
    }
  },
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true
}
```

### Android Studio

1. Install Flutter plugin
2. Install Dart plugin
3. Open project folder
4. Select Flutter/Dart SDK paths
5. Create new emulator or connect device

### PyCharm / IntelliJ IDEA

1. Install Python plugin
2. Install Flask/FastAPI plugin
3. Configure Python interpreter (virtual environment)
4. Create run configuration for FastAPI

---

## Troubleshooting

### Flutter Issues

**Issue: `flutter doctor` shows issues**

```bash
# Run flutter doctor
flutter doctor

# Accept Android licenses
flutter doctor --android-licenses

# Install missing components as suggested
```

**Issue: Build fails - conflicting dependencies**

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**Issue: Hot reload not working**

```bash
# Stop and restart
flutter run -v

# Or rebuild
flutter run --release
```

### Backend Issues

**Issue: Port 8000 already in use**

**Windows**:

```cmd
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

**macOS/Linux**:

```bash
lsof -i :8000
kill -9 <PID>
```

**Issue: Database connection error**

```bash
# Check PostgreSQL is running
# Windows: Services → PostgreSQL
# macOS: brew services list | grep postgresql
# Linux: sudo systemctl status postgresql

# Verify connection string in .env
# Ensure database exists: psql -l
```

**Issue: `ModuleNotFoundError`**

```bash
# Ensure virtual environment is activated
# Reinstall dependencies
pip install -r requirements.txt
```

### Docker Issues

**Issue: Container won't start**

```bash
# Check logs
docker-compose logs db
docker-compose logs server

# Rebuild containers
docker-compose down -v
docker-compose up --build
```

**Issue: Port conflicts**

```bash
# Change port mapping in docker-compose.yml
# ports:
#   - "5434:5432"  # Changed from 5433

docker-compose up -d
```

---

## Development Workflow

### Daily Development Steps

1. **Morning Setup**:

   ```bash
   # Backend
   cd e_wms_mobile/server
   source venv/bin/activate
   uvicorn main:app --reload
   
   # Mobile (new terminal)
   cd e_wms_mobile/app
   flutter run
   ```

2. **Making Changes**:
   - Edit code in your IDE
   - Backend: Changes auto-reload with `--reload` flag
   - Mobile: Changes auto-reload with hot reload (press 'r' in terminal)

3. **Testing Changes**:
   - Test API endpoints: [http://localhost:8000/docs](http://localhost:8000/docs)
   - Test mobile UI on emulator/device

4. **Committing Code**:

   ```bash
   git status
   git add .
   git commit -m "feature: describe your changes"
   git push origin branch-name
   ```

5. **End of Day**:

   ```bash
   # Stop servers
   # Ctrl+C in both terminals
   
   # Or with Docker
   docker-compose down
   ```

### Code Quality Checks

**Mobile (Flutter)**:

```bash
cd app

# Analyze code
flutter analyze

# Format code
flutter format .

# Run tests
flutter test
```

**Backend (Python)**:

```bash
cd server

# Check code style
flake8 . --max-line-length=100

# Format code
black .

# Run tests
pytest
```

### Useful Commands

| Task | Command |
|------|---------|
| Run app | `flutter run` |
| Debug app | `flutter run -v` |
| Build APK | `flutter build apk --release` |
| Clean build | `flutter clean` |
| Update dependencies | `flutter pub upgrade` |
| Generate code | `flutter pub run build_runner build` |
| Format Dart | `flutter format .` |
| Analyze Dart | `flutter analyze` |
| Run Python backend | `uvicorn main:app --reload` |
| Run tests | `pytest` |
| Format Python | `black .` |
| Check Python style | `flake8 .` |

---

## Next Steps

1. **Read Documentation**:
   - Main README.md
   - ARCHITECTURE.md
   - API_REFERENCE.md

2. **Explore Codebase**:
   - Study feature structure
   - Review API endpoints
   - Understand data models

3. **Start Development**:
   - Pick a feature to work on
   - Follow coding standards
   - Test thoroughly before committing

4. **Join Team**:
   - Connect with team members
   - Attend code reviews
   - Share knowledge and learnings

---

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [PEP 8 Python Style Guide](https://www.python.org/dev/peps/pep-0008/)

---

**Last Updated**: May 6, 2026  
**For issues or questions**, contact the development team or check the project wiki.
