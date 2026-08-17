# E-WMS (Electronic Waste Management System) - Mobile Application

Professional documentation for the e-WMS mobile and backend system - A comprehensive waste management solution with Flutter mobile application and FastAPI backend.

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Database Schema](#database-schema)
- [API Endpoints](#api-endpoints)
- [Development Guide](#development-guide)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Project Overview

**E-WMS** is a government-level electronic waste disposal management system designed to streamline waste management operations. The system provides a comprehensive platform for users to manage tasks, receive announcements, track locations, and access personalized profiles.

### Project Purpose

The E-WMS application facilitates efficient waste management by providing:

- User authentication and management
- Task assignment and tracking
- Real-time location mapping for disposal sites
- News and announcement distribution
- User profile management
- Mobile-first experience with offline capabilities

### Status

🚀 **Active Development**

---

## ✨ Key Features

### 📱 Mobile Application (Flutter)

- **Cross-Platform Support**: iOS, Android, macOS, Windows, Linux, Web
- **User Authentication**: Secure sign-up and sign-in with JWT tokens
- **Profile Management**: User profile viewing and management
- **Task Management**: View, track, and manage disposal tasks
- **Location Services**: Real-time location mapping of disposal sites using Google Maps
- **News & Announcements**: Stay updated with latest system announcements
- **Offline Support**: SharedPreferences for local data caching
- **Material Design UI**: Modern, responsive interface
- **Native Splash Screen**: Custom branded splash screens

### 🔙 Backend API (FastAPI)

- **RESTful API Architecture**: Comprehensive API endpoints
- **Authentication & Authorization**: JWT-based authentication middleware
- **Database Management**: PostgreSQL with SQLAlchemy ORM
- **Task Management**: CRUD operations for tasks
- **Location Tracking**: GPS coordinate management for disposal sites
- **User Management**: User registration and authentication
- **News Management**: Announcement and news distribution
- **Security**: Password hashing with bcrypt

---

## 🛠️ Technology Stack

### Frontend (Mobile)

```
Framework:      Flutter 3.9.2+
Language:       Dart
State Management: Flutter Riverpod 3.0.3
HTTP Client:    http 1.6.0
Maps:           Google Maps Flutter 2.14.0
Local Storage:  SharedPreferences 2.5.3
UI Components:  Material Design 3
SVG Support:    flutter_svg 2.2.2
Functional Programming: fpdart 2.0.0-dev.3
Permissions:    permission_handler 12.0.1
Icons:          font_awesome_flutter 10.12.0
Splash Screen:  flutter_native_splash 2.4.7
```

### Backend (Server)

```
Framework:      FastAPI 0.104+
Server:         Uvicorn
Language:       Python 3.13
Database ORM:   SQLAlchemy
Database:       PostgreSQL 15
Authentication: JWT (PyJWT)
Password Hash:  bcrypt
Validation:     Pydantic
Database Driver: psycopg2-binary
```

### DevOps & Infrastructure

```
Containerization: Docker & Docker Compose
Database:        PostgreSQL 15-Alpine
Port Mapping:    API (8000), Database (5433)
Environment:     Alpine Linux for minimal footprint
```

---

## 📂 Project Structure

```
e_wms_mobile/
├── app/                                    # Flutter Mobile Application
│   ├── lib/
│   │   ├── main.dart                      # Application entry point
│   │   ├── main_layout.dart               # Main layout wrapper
│   │   ├── core/
│   │   │   ├── assets/                    # SVG logos, icons, images
│   │   │   ├── constants/                 # Application constants
│   │   │   ├── pages/                     # Core page components
│   │   │   ├── providers/                 # Riverpod state providers
│   │   │   └── widgets/                   # Reusable UI widgets
│   │   ├── feature/                       # Feature modules
│   │   │   ├── auth/                      # Authentication feature
│   │   │   │   ├── views/                 # Sign-in/sign-up pages
│   │   │   │   └── viewmodels/            # Auth business logic
│   │   │   ├── landing/                   # Landing/dashboard feature
│   │   │   │   ├── viewmodels/            # News, tasks, announcements logic
│   │   │   │   └── views/
│   │   │   ├── profile/                   # User profile feature
│   │   │   │   ├── viewmodels/
│   │   │   │   └── views/
│   │   │   ├── discover/                  # Location discovery feature
│   │   │   │   ├── viewmodel/
│   │   │   │   └── views/
│   │   │   └── token/                     # Token management
│   │   ├── utilities/                     # Utility functions
│   │   │   ├── helpers/                   # Helper functions
│   │   │   └── themes/                    # App theming & styling
│   │   └── test/                          # Unit & widget tests
│   ├── android/                           # Android native integration
│   ├── ios/                               # iOS native integration
│   ├── web/                               # Web platform support
│   ├── linux/                             # Linux platform support
│   ├── macos/                             # macOS platform support
│   ├── windows/                           # Windows platform support
│   ├── pubspec.yaml                       # Dart dependencies
│   └── analysis_options.yaml              # Linting rules
│
├── server/                                 # FastAPI Backend Server
│   ├── main.py                            # Application entry point
│   ├── database/
│   │   └── init.py                        # Database connection setup
│   ├── models/                            # SQLAlchemy ORM models
│   │   ├── base.py                        # Base model definition
│   │   ├── user_model.py                  # User data model
│   │   ├── task_model.py                  # Task data model
│   │   ├── news_model.py                  # News data model
│   │   ├── announcement_model.py          # Announcement data model
│   │   └── location_model.py              # Location data model
│   ├── routers/                           # API route handlers
│   │   ├── user_router.py                 # Auth endpoints
│   │   ├── landing_router.py              # Landing data endpoints
│   │   └── location_router.py             # Location endpoints
│   ├── schemas/                           # Pydantic validation schemas
│   │   ├── user_schema.py
│   │   ├── task_schema.py
│   │   ├── news_schema.py
│   │   ├── announcement_schema.py
│   │   └── location_schema.py
│   ├── middlewares/                       # Custom middleware
│   │   └── auth_middleware.py             # JWT authentication middleware
│   ├── utilities/                         # Utility functions
│   │   └── security_pass.py               # Password hashing utilities
│   ├── Dockerfile                         # Docker container setup
│   ├── requirements.txt                   # Python dependencies
│   ├── app.sh                             # Startup script
│   └── README.md                          # Server documentation
│
├── docker-compose.yml                     # Multi-container orchestration
└── README.md                              # This file
```

---

## 🏗️ Architecture

### System Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     Client Layer (Mobile)                   │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              Flutter Mobile Application                 │ │
│  │  ┌──────────────┐  ┌────────────────────────────────┐  │ │
│  │  │  UI Layer    │  │  Features (Auth, Profile, etc) │  │ │
│  │  └──────────────┘  └────────────────────────────────┘  │ │
│  │         ↓                        ↓                      │ │
│  │  ┌─────────────────────────────────────────────────┐   │ │
│  │  │  Riverpod State Management & Data Providers     │   │ │
│  │  └─────────────────────────────────────────────────┘   │ │
│  │         ↓                                               │ │
│  │  ┌─────────────────────────────────────────────────┐   │ │
│  │  │      HTTP Client / API Communication           │   │ │
│  │  └─────────────────────────────────────────────────┘   │ │
│  └────────────────────────────────────────────────────────┘ │
└──────────────────────────┬──────────────────────────────────┘
                           │ HTTP/REST
                           ↓
┌──────────────────────────────────────────────────────────────┐
│                      Server Layer                            │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              FastAPI Application                       │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │  API Endpoints (Routers)                         │  │ │
│  │  │  • /auth (User Authentication)                  │  │ │
│  │  │  • /task-data (Task Management)                 │  │ │
│  │  │  • /location (Location Services)                │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  │         ↓                                               │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │  Middleware Layer (Authentication)               │  │ │
│  │  │  • JWT Token Validation                         │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  │         ↓                                               │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │  Business Logic Layer                            │  │ │
│  │  │  • Data Processing                              │  │ │
│  │  │  • Validation (Pydantic Schemas)               │  │ │
│  │  │  • Security Operations                         │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  │         ↓                                               │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │  Data Access Layer (SQLAlchemy ORM)             │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────┘ │
└──────────────────────────┬──────────────────────────────────┘
                           │ SQL
                           ↓
┌──────────────────────────────────────────────────────────────┐
│                    Database Layer                            │
│  ┌────────────────────────────────────────────────────────┐ │
│  │           PostgreSQL Database                          │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │  Tables:                                         │  │ │
│  │  │  • users       - User accounts & profiles        │  │ │
│  │  │  • tasks       - Disposal tasks                  │  │ │
│  │  │  • news        - News articles                   │  │ │
│  │  │  • announcements - System announcements          │  │ │
│  │  │  • location    - Disposal site locations         │  │ │
│  │  └──────────────────────────────────────────────────┘  │ │
│  └────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

### Data Flow

1. **User Authentication Flow**

   ```
   Mobile App → Sign-in/Sign-up → User Router → Database (Users Table)
      ↓ (JWT Token Generated)
   Token stored in SharedPreferences → Subsequent API calls with token
   ```

2. **Task Management Flow**

   ```
   Mobile App → Request Tasks → Landing Router → Database (Tasks Table)
      ↓
   Riverpod Provider → Cached in state
   ```

3. **Location Services Flow**

   ```
   Mobile App → Location Coordinates → Google Maps Widget → Visual Display
   Mobile App → Request Locations → Location Router → Database (Locations Table)
   ```

---

## 📋 Database Schema

### Users Table

```sql
CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    mobnum VARCHAR(15),
    password BYTEA NOT NULL,
    conpassword BYTEA NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Tasks Table

```sql
CREATE TABLE tasks (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    priority VARCHAR,
    status VARCHAR,
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### News Table

```sql
CREATE TABLE news (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Announcements Table

```sql
CREATE TABLE announcements (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Locations Table

```sql
CREATE TABLE location (
    markerId VARCHAR PRIMARY KEY NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    isFull BOOLEAN NOT NULL,
    hue FLOAT
);
```

---

## 🔌 API Endpoints

### Base URL

```
http://localhost:8000
```

### Authentication Endpoints (`/auth`)

#### 1. User Sign-Up

```
POST /auth/signup
Content-Type: application/json

Request Body:
{
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "mobnum": "+1234567890",
    "password": "SecurePassword123",
    "conpassword": "SecurePassword123"
}

Response: 200 OK
{
    "id": "uuid-here",
    "email": "john.doe@example.com",
    "message": "User created successfully"
}
```

#### 2. User Sign-In

```
POST /auth/signin
Content-Type: application/json

Request Body:
{
    "email": "john.doe@example.com",
    "password": "SecurePassword123"
}

Response: 200 OK
{
    "access_token": "jwt-token-here",
    "token_type": "bearer",
    "user_id": "uuid-here"
}
```

### Task Management Endpoints

#### 3. Create Task

```
POST /task-data
Content-Type: application/json
Authorization: Bearer <jwt-token>

Request Body:
{
    "title": "Clean Disposal Site A",
    "description": "Collect and sort electronic waste",
    "priority": "HIGH",
    "status": "PENDING",
    "due_date": "2026-05-20T10:00:00"
}

Response: 200 OK
{
    "id": "uuid-here",
    "title": "Clean Disposal Site A",
    "status": "PENDING"
}
```

#### 4. Get All Tasks

```
GET /task-data
Authorization: Bearer <jwt-token>

Response: 200 OK
[
    {
        "id": "uuid-1",
        "title": "Task 1",
        "priority": "HIGH",
        "status": "PENDING",
        "due_date": "2026-05-20T10:00:00"
    },
    ...
]
```

### Location Endpoints

#### 5. Get Locations

```
GET /location
Authorization: Bearer <jwt-token>

Response: 200 OK
[
    {
        "markerId": "loc-1",
        "latitude": 40.7128,
        "longitude": -74.0060,
        "isFull": false
    },
    ...
]
```

#### 6. Create Location

```
POST /location
Content-Type: application/json
Authorization: Bearer <jwt-token>

Request Body:
{
    "markerId": "loc-new",
    "latitude": 40.7128,
    "longitude": -74.0060,
    "isFull": false
}

Response: 200 OK
{
    "markerId": "loc-new",
    "latitude": 40.7128,
    "longitude": -74.0060,
    "isFull": false
}
```

### News & Announcements Endpoints

#### 7. Get News

```
GET /news-data
Authorization: Bearer <jwt-token>

Response: 200 OK
[
    {
        "id": "uuid-1",
        "title": "New Waste Management Policy",
        "description": "Updated guidelines...",
        "created_at": "2026-05-06T10:00:00"
    },
    ...
]
```

#### 8. Get Announcements

```
GET /announcement-data
Authorization: Bearer <jwt-token>

Response: 200 OK
[
    {
        "id": "uuid-1",
        "title": "System Maintenance",
        "description": "Scheduled maintenance...",
        "created_at": "2026-05-06T10:00:00"
    },
    ...
]
```

---

## 🚀 Prerequisites

### System Requirements

- **OS**: Windows, macOS, or Linux
- **RAM**: 4GB minimum (8GB recommended)
- **Storage**: 10GB available space

### Required Software

#### For Mobile Development

- Flutter SDK 3.9.2+
- Dart 3.9.2+
- Android Studio (for Android development)
- Xcode (for iOS development on macOS)
- Visual Studio Code or Android Studio

#### For Backend Development

- Python 3.13+
- pip (Python package manager)
- PostgreSQL 15+
- Docker (for containerized deployment)
- Docker Compose

#### Optional

- Git (version control)
- Postman (API testing)
- DBeaver (database management)

---

## 📦 Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd e_wms_mobile
```

### 2. Backend Setup

#### Option A: Using Docker Compose (Recommended)

```bash
# Navigate to project root
cd e_wms_mobile

# Start services (PostgreSQL + FastAPI)
docker-compose up -d

# Verify services are running
docker-compose ps

# Check logs
docker-compose logs -f server
docker-compose logs -f db
```

**Access Points:**

- API: `http://localhost:8000`
- Database: `localhost:5433`
- Database Name: `fastapi_db`
- Default User: `postgres`
- Default Password: `postgres`

#### Option B: Local Development Setup

```bash
# Navigate to server directory
cd server

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Set environment variables
# Create .env file
# DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:5432/fastapi_db

# Start PostgreSQL database
# (Ensure PostgreSQL is installed and running)

# Run the server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### 3. Mobile Application Setup

```bash
# Navigate to app directory
cd app

# Get Flutter dependencies
flutter pub get

# Generate required files (Riverpod code generation)
flutter pub run build_runner build --delete-conflicting-outputs

# Configure API endpoint
# Edit: lib/utilities/constants/ or environment configuration
# Update API_BASE_URL to http://<your-server-ip>:8000

# Run on Android emulator
flutter run -d emulator

# Run on iOS simulator (macOS only)
flutter run -d iPhone

# Run on physical device
flutter run

# Build release APK (Android)
flutter build apk --release

# Build release IPA (iOS, requires macOS)
flutter build ios --release

# Build for Web
flutter build web
```

### 4. Environment Configuration

#### Backend Environment Variables

Create `server/.env`:

```env
DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:5432/fastapi_db
PYTHONUNBUFFERED=1
SECRET_KEY=your-secret-key-here
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

#### Mobile Environment

Update API base URL in Flutter:

```dart
// lib/utilities/constants/api_constants.dart (if exists)
const String API_BASE_URL = 'http://192.168.1.100:8000';  // Update with server IP
```

---

## 💻 Development Guide

### Running the Full Stack

#### Using Docker Compose

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Reset (remove volumes)
docker-compose down -v
```

#### Manual Setup

```bash
# Terminal 1: Backend
cd server
source venv/bin/activate
uvicorn main:app --reload

# Terminal 2: Mobile
cd app
flutter run
```

### Code Organization

#### Frontend (Flutter)

- **MVVM Pattern**: Models → ViewModels (Riverpod Providers) → Views
- **Feature-Based Structure**: Each feature is self-contained
- **Separation of Concerns**: Core/Utilities separate from features

#### Backend (FastAPI)

- **MVC Pattern**: Models (SQLAlchemy) → Controllers (Routers) → Views (Response)
- **Router-Based API**: Organized by functionality
- **Middleware for Cross-Cutting**: Authentication, logging, etc.

### Making Changes

#### Adding a New Feature (Mobile)

1. Create feature folder: `lib/feature/feature_name/`
2. Structure:

   ```
   feature_name/
   ├── models/
   ├── views/
   └── viewmodels/
   ```

3. Create Riverpod provider for state management
4. Implement views using Flutter widgets
5. Connect to API via HTTP client

#### Adding a New API Endpoint (Backend)

1. Create model in `server/models/`: `new_model.py`
2. Create schema in `server/schemas/`: `new_schema.py`
3. Create router in `server/routers/`: `new_router.py`
4. Register router in `server/main.py`:

   ```python
   from routers import new_router
   app.include_router(new_router.router, prefix="/endpoint")
   ```

5. Use `sqlalchemy` ORM for database operations

### Testing

#### Backend Testing

```bash
# Run tests (if test suite exists)
pytest

# With coverage
pytest --cov=.
```

#### Mobile Testing

```bash
# Run widget tests
flutter test

# Run integration tests
flutter test integration_test/
```

### Debugging

#### Backend Debugging

- FastAPI automatic documentation: `http://localhost:8000/docs`
- Alternative documentation: `http://localhost:8000/redoc`
- Enable logging: Already enabled in uvicorn with `--reload`

#### Mobile Debugging

```bash
# Enable verbose logging
flutter run -v

# Debug specific device
flutter run -d <device-id> -v

# List available devices
flutter devices
```

### Common Development Tasks

#### Update Dependencies

```bash
# Mobile
cd app
flutter pub upgrade

# Backend
cd server
pip install --upgrade -r requirements.txt
```

#### Generate Code

```bash
# Mobile (Riverpod code generation)
cd app
flutter pub run build_runner build

# Watch for changes
flutter pub run build_runner watch
```

---

## 🐳 Deployment

### Docker Deployment

#### Build Custom Docker Images

```bash
# Build backend image
docker build -t wms-backend:latest ./server

# Build and tag
docker build -t your-registry/wms-backend:1.0.0 ./server
docker push your-registry/wms-backend:1.0.0
```

#### Update docker-compose.yml for Production

```yaml
services:
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: ${DB_NAME}
    volumes:
      - db_data:/var/lib/postgresql/data
    restart: always

  server:
    image: wms-backend:latest
    environment:
      DATABASE_URL: postgresql://${DB_USER}:${DB_PASSWORD}@db:5432/${DB_NAME}
      DEBUG: "false"
    depends_on:
      db:
        condition: service_healthy
    restart: always
    ports:
      - "8000:8000"
```

### Cloud Deployment Options

#### AWS Deployment

```bash
# Push to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin <aws-account-id>.dkr.ecr.<region>.amazonaws.com
docker tag wms-backend:latest <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wms-backend:latest
docker push <aws-account-id>.dkr.ecr.<region>.amazonaws.com/wms-backend:latest

# Deploy via ECS or EKS
# (Configure task definitions or Kubernetes manifests)
```

#### Google Cloud Deployment

```bash
# Push to Google Container Registry
gcloud builds submit --tag gcr.io/PROJECT-ID/wms-backend ./server
gcloud run deploy wms-backend --image gcr.io/PROJECT-ID/wms-backend --region us-central1
```

#### Azure Deployment

```bash
# Push to Azure Container Registry
az acr build --registry <registry-name> --image wms-backend:latest ./server

# Deploy to App Service
az container create --resource-group <group> --name wms-api --image <registry>.azurecr.io/wms-backend:latest
```

### Production Checklist

- [ ] Set `DEBUG=False` in FastAPI settings
- [ ] Update `ALLOWED_HOSTS` for CORS
- [ ] Configure proper database backups
- [ ] Set up SSL/TLS certificates
- [ ] Implement rate limiting
- [ ] Enable logging and monitoring
- [ ] Configure environment variables securely
- [ ] Update Flutter API endpoints to production server
- [ ] Enable crash reporting
- [ ] Set up CI/CD pipeline

---

## 📱 Building Release Versions

### Android Release Build

```bash
cd app

# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release

# Output location
# build/app/outputs/flutter-apk/app-release.apk
# build/app/outputs/bundle/release/app-release.aab
```

### iOS Release Build (macOS only)

```bash
cd app

# Build IPA
flutter build ios --release

# Output needs to be archived in Xcode
open ios/Runner.xcworkspace
# Archive via Xcode → Product → Archive
```

### Web Release Build

```bash
cd app

# Build web
flutter build web --release

# Output location: build/web/
# Deploy to any static hosting (Firebase, Netlify, AWS S3, etc.)
```

---

## 🤝 Contributing

### Development Workflow

1. **Create Feature Branch**

   ```bash
   git checkout -b feature/feature-name
   ```

2. **Make Changes**
   - Follow existing code style
   - Write comments for complex logic
   - Update tests as needed

3. **Commit Changes**

   ```bash
   git commit -m "feat: add new feature description"
   ```

4. **Push and Create Pull Request**

   ```bash
   git push origin feature/feature-name
   ```

### Code Style Guidelines

#### Dart/Flutter

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check code
- Format code: `flutter format .`

#### Python

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- Use `black` for formatting: `black .`
- Lint with `flake8`: `flake8 .`

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Example:

```
feat: add user authentication endpoint

Implement JWT-based authentication for user signin/signup.
- Add sign-in route
- Add sign-up route
- Hash passwords using bcrypt

Closes #123
```

---

## 📊 Project Statistics

| Component | Details |
|-----------|---------|
| **Languages** | Dart, Python, Kotlin, Swift |
| **Total Dependencies** | 25+ (Mobile), 7 (Backend) |
| **Supported Platforms** | Android, iOS, Web, Windows, macOS, Linux |
| **Database** | PostgreSQL 15 |
| **API Type** | RESTful |
| **Authentication** | JWT |
| **Package Manager** | pub (Dart), pip (Python) |

---

## 🔒 Security Considerations

### Authentication

- JWT tokens with configurable expiry
- Password hashing with bcrypt
- Secure token storage in SharedPreferences

### Data Protection

- HTTPS/TLS for all communications (in production)
- SQL Injection prevention via SQLAlchemy ORM
- Input validation via Pydantic schemas

### API Security

- CORS configuration required
- Rate limiting recommended
- API key rotation policies

### Mobile Security

- Secure local storage for sensitive data
- Permission requests for location/camera
- SSL pinning recommended for production

---

## 📞 Support & Troubleshooting

### Common Issues

#### Database Connection Error

```
Error: could not translate host name "db" to address
```

**Solution**: Ensure Docker containers are running and networked correctly.

```bash
docker-compose ps
docker network ls
```

#### Port Already in Use

```
Error: Address already in use
```

**Solution**: Kill process using the port or use different port.

```bash
# Check port usage
lsof -i :8000  # macOS/Linux
netstat -ano | findstr :8000  # Windows

# Kill process
kill -9 <PID>  # macOS/Linux
taskkill /PID <PID> /F  # Windows
```

#### Flutter Build Issues

```
Error: Could not resolve all artifacts
```

**Solution**: Clear pub cache and fetch dependencies again.

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Useful Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [SQLAlchemy Documentation](https://docs.sqlalchemy.org/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)

---

## 📄 License

This project is licensed under the Government of [Country] Electronic Waste Management License.

---

## 👥 Authors & Contributors

- **Project Lead**: [Your Organization]
- **Development Team**: [Team Members]
- **Last Updated**: May 6, 2026

---

## 📝 Changelog

### Version 1.0.0 (Current)

- Initial release
- User authentication system
- Task management
- Location tracking with Google Maps
- News and announcements system
- Multi-platform mobile support

---

## 🗺️ Roadmap

### Upcoming Features

- [ ] Offline sync capabilities
- [ ] Advanced analytics dashboard
- [ ] Real-time notifications
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Photo upload for waste documentation
- [ ] QR code scanning for waste tracking
- [ ] AI-powered waste classification

### Performance Optimizations

- [ ] Image compression
- [ ] Database query optimization
- [ ] API response caching
- [ ] Bundle size reduction

---

**For more information, contact the development team or check the official project wiki.**
