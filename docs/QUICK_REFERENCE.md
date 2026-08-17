# E-WMS Quick Reference Guide

## Essential Commands and Information at a Glance

---

## 🚀 Quick Start

### One-Command Setup (Docker)

```bash
cd e_wms_mobile
docker-compose up -d
# Wait for services to start
# Access API at http://localhost:8000
```

### Manual Setup

```bash
# Terminal 1: Backend
cd e_wms_mobile/server
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
uvicorn main:app --reload

# Terminal 2: Mobile (new terminal)
cd e_wms_mobile/app
flutter pub get
flutter run
```

---

## 📱 Mobile Development

### Essential Commands

| Task | Command |
|------|---------|
| Get dependencies | `flutter pub get` |
| Generate code | `flutter pub run build_runner build` |
| Run app | `flutter run` |
| Run with verbose | `flutter run -v` |
| Run on device | `flutter run -d <device-id>` |
| Build APK | `flutter build apk --release` |
| Build IPA | `flutter build ios --release` |
| Build Web | `flutter build web --release` |
| Format code | `flutter format .` |
| Analyze code | `flutter analyze` |
| Run tests | `flutter test` |
| View devices | `flutter devices` |
| Clean build | `flutter clean` |

### File Structure

```
app/
├── lib/
│   ├── main.dart              # Entry point
│   ├── core/                  # Shared resources
│   │   ├── assets/            # Images, SVGs
│   │   ├── constants/         # Constants
│   │   ├── providers/         # Riverpod providers
│   │   └── widgets/           # Reusable widgets
│   ├── feature/               # Feature modules
│   │   ├── auth/              # Authentication
│   │   ├── landing/           # Dashboard
│   │   ├── profile/           # User profile
│   │   └── discover/          # Location discovery
│   └── utilities/             # Helpers, themes
├── test/                      # Unit/widget tests
└── pubspec.yaml              # Dependencies
```

### Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Build fails | `flutter clean && flutter pub get` |
| Hot reload not working | Stop and restart: `flutter run` |
| Port in use | Kill process: `lsof -i :8000` then `kill -9 <PID>` |
| Dependencies conflict | `flutter pub upgrade` |
| Generated files missing | `flutter pub run build_runner build --delete-conflicting-outputs` |

---

## 🔧 Backend Development

### Essential Commands

| Task | Command |
|------|---------|
| Create venv | `python -m venv venv` |
| Activate venv (Windows) | `venv\Scripts\activate` |
| Activate venv (Unix) | `source venv/bin/activate` |
| Install dependencies | `pip install -r requirements.txt` |
| Run server | `uvicorn main:app --reload` |
| Format code | `black .` |
| Lint code | `flake8 . --max-line-length=100` |
| Run tests | `pytest` |
| Generate coverage | `pytest --cov=.` |
| Deactivate venv | `deactivate` |

### API Documentation

- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

### Project Structure

```
server/
├── main.py                    # App entry point
├── database/
│   └── init.py               # DB connection
├── models/                   # SQLAlchemy models
│   ├── base.py
│   ├── user_model.py
│   ├── task_model.py
│   ├── news_model.py
│   ├── announcement_model.py
│   └── location_model.py
├── routers/                  # API endpoints
│   ├── user_router.py
│   ├── landing_router.py
│   └── location_router.py
├── schemas/                  # Pydantic models
├── middlewares/              # Custom middleware
├── utilities/                # Helper functions
├── requirements.txt          # Python dependencies
├── Dockerfile               # Container config
└── .env                     # Environment variables
```

---

## 🐳 Docker Commands

| Task | Command |
|------|---------|
| Start all services | `docker-compose up -d` |
| Stop all services | `docker-compose down` |
| View logs | `docker-compose logs -f` |
| View specific logs | `docker-compose logs -f server` |
| Remove all volumes | `docker-compose down -v` |
| Rebuild containers | `docker-compose up --build -d` |
| Execute command in container | `docker-compose exec server bash` |

---

## 🗄️ Database Commands

### PostgreSQL (Local)

| Task | Command |
|------|---------|
| Connect to DB | `psql -U postgres -d fastapi_db` |
| List tables | `\dt` |
| View table schema | `\d+ <table_name>` |
| Backup database | `pg_dump -U postgres fastapi_db > backup.sql` |
| Restore database | `psql -U postgres fastapi_db < backup.sql` |
| Create database | `CREATE DATABASE fastapi_db;` |

### Quick Queries

```sql
-- View all users
SELECT * FROM users;

-- View all tasks
SELECT * FROM tasks;

-- Get pending tasks
SELECT * FROM tasks WHERE status = 'PENDING';

-- Count tasks by status
SELECT status, COUNT(*) FROM tasks GROUP BY status;

-- View locations
SELECT * FROM location;
```

---

## 📋 API Endpoints Quick Reference

### Base URL

```
http://localhost:8000
```

### Authentication

| Method | Endpoint | Purpose |
|--------|----------|---------|
| POST | `/auth/signup` | Register new user |
| POST | `/auth/signin` | Login user |

### Tasks

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/task-data` | Get all tasks |
| POST | `/task-data` | Create task |

### News & Announcements

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/news-data` | Get news articles |
| POST | `/news-data` | Create news article |
| GET | `/announcement-data` | Get announcements |
| POST | `/announcement-data` | Create announcement |

### Locations

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/location` | Get all locations |
| POST | `/location` | Create location |

### Example Requests

**Sign Up**:

```bash
curl -X POST http://localhost:8000/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fname": "John",
    "lname": "Doe",
    "email": "john@example.com",
    "mobnum": "+1234567890",
    "password": "Pass123!",
    "conpassword": "Pass123!"
  }'
```

**Sign In**:

```bash
curl -X POST http://localhost:8000/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "Pass123!"
  }'
```

**Get Tasks** (with auth):

```bash
curl -X GET http://localhost:8000/task-data \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

---

## 🔐 Authentication

### JWT Token Handling

**Store token (Flutter)**:

```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', token);
```

**Use token in requests**:

```dart
final token = prefs.getString('auth_token');
final response = await http.get(
  Uri.parse('http://localhost:8000/task-data'),
  headers: {'Authorization': 'Bearer $token'},
);
```

**Retrieve token**:

```dart
final token = prefs.getString('auth_token');
```

**Logout**:

```dart
await prefs.remove('auth_token');
```

---

## 🧪 Testing Quick Guide

### Mobile (Flutter)

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/feature/auth/sign_in_test.dart

# Generate coverage
flutter test --coverage

# View coverage
open coverage/lcov.info
```

### Backend (Python)

```bash
# Run all tests
pytest

# Run specific test
pytest tests/test_auth.py::test_signup

# Verbose output
pytest -v

# Coverage report
pytest --cov=. --cov-report=html
```

---

## 📦 Dependency Management

### Flutter

```bash
# Add dependency
flutter pub add <package_name>

# Remove dependency
flutter pub remove <package_name>

# Upgrade dependencies
flutter pub upgrade

# List outdated dependencies
flutter pub outdated

# Get dependencies
flutter pub get

# Upgrade to latest versions
flutter pub upgrade --major-versions
```

### Python

```bash
# Install specific version
pip install package_name==version

# Upgrade package
pip install --upgrade package_name

# List installed packages
pip list

# Create requirements file
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt

# Update all packages
pip install --upgrade -r requirements.txt
```

---

## 🛠️ Development Environment

### Environment Variables

**Backend (.env)**:

```env
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/fastapi_db
DEBUG=true
SECRET_KEY=your-secret-key
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

**Mobile (lib/utilities/constants/api_constants.dart)**:

```dart
const String API_BASE_URL = 'http://192.168.1.100:8000';
```

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| [README.md](README.md) | Main project documentation |
| [ARCHITECTURE.md](ARCHITECTURE.md) | System architecture & design |
| [API_REFERENCE.md](API_REFERENCE.md) | Complete API documentation |
| [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md) | Database design & queries |
| [DEVELOPER_SETUP.md](DEVELOPER_SETUP.md) | Development setup guide |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contributing guidelines |

---

## 🐛 Debugging Tips

### Flutter Debugging

```dart
// Simple print
print('Value: $value');

// Debug print with custom prefix
debugPrint('Auth State Changed: $state');

// Breakpoints in VS Code
// Click line number to set breakpoint
// F5 to start debugging

// Watch variables
// Right-click variable → Add Watch Expression
```

### Backend Debugging

```python
# Print debugging
print(f"Value: {value}")

# Use pdb debugger
import pdb
pdb.set_trace()

# Run with debugging
python -m pdb main.py

# Or in IDE
# Set breakpoint and F5 to debug
```

### Logging

**Flutter**:

```dart
import 'package:wms_app/utilities/helpers/debug_print.dart';

debugPrintWithTime('Message');
```

**Python**:

```python
import logging

logger = logging.getLogger(__name__)
logger.debug("Debug message")
logger.info("Info message")
logger.warning("Warning message")
logger.error("Error message")
```

---

## 🚀 Deployment Checklist

### Pre-Deployment

- [ ] All tests passing
- [ ] Code reviewed and approved
- [ ] No console errors/warnings
- [ ] Performance optimized
- [ ] Security audit completed
- [ ] Documentation updated
- [ ] Environment variables configured
- [ ] Database backups created

### Deployment Commands

```bash
# Backend
docker build -t wms-backend:latest ./server
docker push your-registry/wms-backend:latest

# Mobile
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
flutter build web --release

# Database migration
python -m alembic upgrade head
```

---

## 📞 Quick Help

### Getting Help

1. Check [README.md](README.md) for general info
2. Check [ARCHITECTURE.md](ARCHITECTURE.md) for system design
3. Check [API_REFERENCE.md](API_REFERENCE.md) for API details
4. Check [DEVELOPER_SETUP.md](DEVELOPER_SETUP.md) for setup help
5. Search existing [issues](https://github.com/ORIGINAL_OWNER/e_wms_mobile/issues)
6. Contact development team

### Common Terminal Tricks

```bash
# Clear terminal
clear  # or Ctrl+L

# Stop running process
Ctrl+C

# Stop and exit Python debugger
quit()

# List running Docker containers
docker ps

# Kill process on port
lsof -i :8000
kill -9 <PID>

# View recent git history
git log --oneline -10

# Show uncommitted changes
git diff
```

---

## 🔗 Useful Links

- [Flutter Docs](https://flutter.dev/docs)
- [FastAPI Docs](https://fastapi.tiangolo.com/)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Docker Docs](https://docs.docker.com/)
- [Git Reference](https://git-scm.com/docs)
- [Dart Docs](https://dart.dev/)
- [Python Docs](https://docs.python.org/)

---

## Version Info

| Component | Version |
|-----------|---------|
| Flutter | 3.9.2+ |
| Dart | 3.9.2+ |
| Python | 3.13+ |
| PostgreSQL | 15 |
| FastAPI | 0.104+ |
| Docker | 20.10+ |

---

**Last Updated**: May 6, 2026  
**Quick Reference v1.0**

---

## Pro Tips 💡

1. **Use aliases for common commands**:

   ```bash
   alias fr='flutter run'
   alias fb='flutter build'
   alias fp='flutter pub'
   ```

2. **Set up IDE shortcuts**:
   - Format on save
   - Lint on save
   - Run tests on save

3. **Keep terminals organized**:
   - Backend terminal
   - Mobile terminal
   - Database terminal

4. **Use git pre-hooks**:
   - Auto-format before commit
   - Run tests before push

5. **Monitor API traffic**:
   - Use REST Client extension
   - Keep API docs tab open
   - Use Postman for complex requests

---

See also: [Full Documentation](#-documentation-files)
