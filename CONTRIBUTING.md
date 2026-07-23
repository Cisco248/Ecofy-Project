# E-WMS Contributing Guidelines

## How to Contribute to E-WMS Project

Thank you for your interest in contributing to the E-WMS (Electronic Waste Management System) project! This document provides guidelines and instructions for contributing code, documentation, and other improvements.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Development Workflow](#development-workflow)
4. [Code Style Guidelines](#code-style-guidelines)
5. [Commit Message Format](#commit-message-format)
6. [Testing Guidelines](#testing-guidelines)
7. [Pull Request Process](#pull-request-process)
8. [Documentation](#documentation)
9. [Review Process](#review-process)
10. [Common Issues](#common-issues)

---

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors regardless of age, body size, disability, ethnicity, gender identity, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Expected Behavior

- Use welcoming and inclusive language
- Be respectful of differing opinions and experiences
- Provide constructive criticism
- Focus on what is best for the community
- Show empathy towards other contributors

### Unacceptable Behavior

- Harassment or discrimination of any kind
- Unwelcome sexual attention or advances
- Trolling, insulting comments, or personal attacks
- Publishing private information without consent
- Other professional conduct violations

---

## Getting Started

### 1. Fork the Repository

```bash
# Click "Fork" on GitHub to create your copy
# Clone your fork
git clone https://github.com/YOUR_USERNAME/e_wms_mobile.git
cd e_wms_mobile
```

### 2. Add Upstream Remote

```bash
# Add reference to original repository
git remote add upstream https://github.com/ORIGINAL_OWNER/e_wms_mobile.git

# Verify remotes
git remote -v
```

### 3. Create Feature Branch

```bash
# Update local main
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 4. Set Up Development Environment

Follow the [DEVELOPER_SETUP.md](DEVELOPER_SETUP.md) guide to set up your local environment.

---

## Development Workflow

### Before Starting Work

1. **Check existing issues and PRs**: Avoid duplicate work
2. **Create an issue** (if not already created): Describe what you plan to work on
3. **Comment on issue**: Let others know you're working on it
4. **Assign to yourself**: If you have permissions

### During Development

1. **Create feature branch** from updated `main`
2. **Make focused commits** on logical changes
3. **Write tests** for new features
4. **Test locally** before pushing
5. **Keep branch updated** with upstream changes

```bash
# Keep branch updated
git fetch upstream
git rebase upstream/main

# Or merge if rebase causes issues
git merge upstream/main
```

### Before Creating PR

1. **Run all tests locally**:

   ```bash
   # Mobile
   cd app && flutter test
   
   # Backend
   cd server && pytest
   ```

2. **Check code formatting**:

   ```bash
   # Mobile
   cd app && flutter format .
   
   # Backend
   cd server && black .
   ```

3. **Run code analysis**:

   ```bash
   # Mobile
   cd app && flutter analyze
   
   # Backend
   cd server && flake8 . --max-line-length=100
   ```

4. **Verify no conflicts**:

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

---

## Code Style Guidelines

### Dart/Flutter Style Guide

Follow [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)

**Key Points**:

- Use 2-space indentation
- Use camelCase for variables and methods
- Use PascalCase for classes and types
- Prefix private members with underscore
- Use `final` for values that don't change

**Example**:

```dart
class UserModel {
  final String id;
  final String firstName;
  final String email;
  
  const UserModel({
    required this.id,
    required this.firstName,
    required this.email,
  });
  
  String get fullName => '$firstName Doe';
}

// ViewModel
final userViewModelProvider = StateNotifierProvider<UserViewModel, UserState>((ref) {
  return UserViewModel();
});
```

**Formatting**:

```bash
flutter format lib/
```

**Linting**:

```bash
flutter analyze
```

### Python Style Guide

Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/)

**Key Points**:

- Use 4-space indentation
- Use snake_case for variables and functions
- Use PascalCase for classes
- Use UPPER_CASE for constants
- Maximum line length: 88 characters (black default)

**Example**:

```python
from sqlalchemy import Column, String, Integer
from models.base import BASE

class UserModel(BASE):
    """SQLAlchemy model for user accounts."""
    
    __tablename__ = "users"
    
    id = Column(String, primary_key=True, index=True)
    email = Column(String(50), unique=True, nullable=False, index=True)
    first_name = Column(String(20), nullable=False)
    last_name = Column(String(20), nullable=False)

def get_user_by_email(db: Session, email: str) -> Optional[UserModel]:
    """Retrieve user by email address."""
    return db.query(UserModel).filter(UserModel.email == email).first()
```

**Formatting**:

```bash
black .
```

**Linting**:

```bash
flake8 . --max-line-length=88
```

### General Code Quality

**Documentation**:

- Add docstrings to all public functions/classes
- Use meaningful variable names
- Comment complex logic
- Keep functions focused and small

**DRY Principle**:

- Don't repeat code
- Extract common functionality
- Use helper functions/utilities

**Error Handling**:

```dart
// Dart: Use try-catch
try {
  final response = await api.getUser(id);
  return response;
} catch (e) {
  print('Error: $e');
  rethrow;
}
```

```python
# Python: Use specific exceptions
try:
    user = db.query(UserModel).filter(UserModel.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user
except SQLAlchemyError as e:
    logger.error(f"Database error: {e}")
    raise HTTPException(status_code=500, detail="Database error")
```

---

## Commit Message Format

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only
- **style**: Code style changes (formatting, semicolons, etc.)
- **refactor**: Code refactoring without feature changes
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **chore**: Build, dependencies, CI/CD changes
- **ci**: CI/CD configuration changes

### Subject Line

- Use imperative mood ("add" not "added" or "adds")
- Don't capitalize first letter
- No period at the end
- Maximum 50 characters

### Body

- Explain what and why, not how
- Wrap at 72 characters
- Separate from subject with blank line

### Footer

- Reference issues: `Fixes #123`, `Closes #456`
- Breaking changes: `BREAKING CHANGE: description`

### Examples

**Feature Commit**:

```
feat(auth): add JWT token refresh endpoint

Implement token refresh functionality to allow users to extend
their session without re-authenticating. Uses both access and
refresh tokens for improved security.

Fixes #123
```

**Bug Fix Commit**:

```
fix(api): handle null response from database

Fix NullPointerException when database returns empty result set.
Add proper null checking before accessing response properties.

Fixes #456
```

**Documentation Commit**:

```
docs: update API reference with new endpoints

Add comprehensive documentation for newly added location
management endpoints including request/response examples.
```

---

## Testing Guidelines

### Test Coverage Requirements

- **Mobile (Flutter)**:
  - Minimum 70% code coverage
  - All public methods should have tests
  - Critical user flows should have widget tests

- **Backend (Python)**:
  - Minimum 80% code coverage
  - All endpoints should have tests
  - All business logic should have unit tests

### Writing Tests

**Flutter Widget Tests**:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignInPage', () {
    testWidgets('displays sign-in form', (WidgetTester tester) async {
      await tester.pumpWidget(const SignInPage());
      
      expect(find.byType(TextField), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
    
    testWidgets('validates email input', (WidgetTester tester) async {
      await tester.pumpWidget(const SignInPage());
      
      await tester.enterText(find.byType(TextField).first, 'invalid-email');
      await tester.pumpWidget(const SignInPage());
      
      expect(find.text('Invalid email'), findsOneWidget);
    });
  });
}
```

**Python API Tests**:

```python
import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

@pytest.fixture
def test_user():
    return {
        "fname": "John",
        "lname": "Doe",
        "email": "john.test@example.com",
        "password": "TestPass123!",
        "conpassword": "TestPass123!"
    }

def test_signup(test_user):
    response = client.post("/auth/signup", json=test_user)
    assert response.status_code == 200
    assert response.json()["email"] == test_user["email"]

def test_signin(test_user):
    # First signup
    client.post("/auth/signup", json=test_user)
    
    # Then signin
    response = client.post("/auth/signin", json={
        "email": test_user["email"],
        "password": test_user["password"]
    })
    assert response.status_code == 200
    assert "access_token" in response.json()
```

### Running Tests

**Mobile**:

```bash
cd app

# Run all tests
flutter test

# Run specific test file
flutter test test/feature/auth/sign_in_test.dart

# Run with coverage
flutter test --coverage

# Check coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**Backend**:

```bash
cd server

# Run all tests
pytest

# Run specific test file
pytest tests/test_auth.py

# Run with coverage
pytest --cov=. --cov-report=html

# Check coverage
open htmlcov/index.html
```

---

## Pull Request Process

### Creating a PR

1. **Push your branch**:

   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create PR on GitHub**:
   - Click "Compare & pull request"
   - Fill in PR template
   - Add descriptive title and description

### PR Title Format

```
[COMPONENT] Brief description of changes

Examples:
[Mobile] Add user profile editing feature
[Backend] Fix task creation endpoint
[Docs] Update API reference
```

### PR Description Template

```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] New feature
- [ ] Bug fix
- [ ] Breaking change
- [ ] Documentation update

## Related Issues
Fixes #123

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] All tests passing locally

## Screenshots (if applicable)
<!-- Add screenshots for UI changes -->

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No breaking changes introduced
```

### PR Size Guidelines

- **Small**: < 200 lines (ideal)
- **Medium**: 200-500 lines (acceptable)
- **Large**: > 500 lines (try to break into smaller PRs)

### Do's and Don'ts

**Do's**:

- Keep PRs focused on single feature/fix
- Make small, logical commits
- Test thoroughly before submitting
- Provide clear descriptions
- Respond promptly to reviews
- Be open to feedback

**Don'ts**:

- Mix multiple features in one PR
- Include unrelated changes
- Force push after review starts
- Ignore test failures
- Be defensive about feedback

---

## Documentation

### When to Document

- New features
- API changes
- Breaking changes
- Complex algorithms
- Setup instructions
- Configuration options

### Documentation Formats

**Code Comments**:

```dart
/// Authenticates user with email and password.
/// 
/// Returns JWT token on success, throws exception on failure.
Future<String> signIn(String email, String password) async {
  // Implementation
}
```

**README Updates**:

- Update main [README.md](README.md) for significant changes
- Update relevant guides for feature documentation

**API Documentation**:

- Update [API_REFERENCE.md](API_REFERENCE.md) for endpoint changes
- Use OpenAPI/Swagger format

**Architecture Documentation**:

- Update [ARCHITECTURE.md](ARCHITECTURE.md) for architecture changes
- Include diagrams when helpful

---

## Review Process

### What Reviewers Look For

1. **Correctness**: Does it work as intended?
2. **Code Quality**: Does it follow style guidelines?
3. **Testing**: Is it adequately tested?
4. **Documentation**: Is it well-documented?
5. **Security**: Are there security implications?
6. **Performance**: Could it be optimized?

### Handling Review Comments

1. **Acknowledge** the comment
2. **Discuss** if you disagree
3. **Update** code if agreed
4. **Mark as resolved** when fixed
5. **Request re-review** when done

**Response Examples**:

```
✓ Done - Updated email validation logic

? Can you clarify what you mean by "optimize query"?

→ I disagree because this pattern is consistent with 
  the rest of the codebase. Let me know if we should 
  refactor all similar instances.
```

### Approval Requirements

- Minimum 2 approvals from maintainers
- All comments resolved
- All tests passing
- No merge conflicts

---

## Common Issues

### Merge Conflicts

```bash
# Get latest upstream
git fetch upstream

# Rebase your branch
git rebase upstream/main

# If conflicts occur, fix them in your editor
# Then continue rebase
git rebase --continue

# Force push to your fork
git push -f origin feature/your-feature-name
```

### Test Failures

```bash
# Check what failed
flutter test -v  # or pytest -v

# Fix the issue
# Re-run tests
flutter test

# Commit fix
git add .
git commit -m "fix: resolve test failures"
```

### Code Style Issues

```bash
# Auto-format code
flutter format . && flutter analyze
# or
black . && flake8 .

# Commit formatted changes
git add .
git commit -m "style: format code"
```

### Build Failures

```bash
# Clean build
flutter clean && flutter pub get
# or
cd server && pip install -r requirements.txt

# Try building again
flutter build apk
# or
python main.py
```

---

## Resources

- [Git Guide](https://git-scm.com/doc)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [PEP 8](https://www.python.org/dev/peps/pep-0008/)
- [Testing Best Practices](https://en.wikipedia.org/wiki/Software_testing)

---

## Questions?

- Check existing [issues](https://github.com/ORIGINAL_OWNER/e_wms_mobile/issues)
- Read [ARCHITECTURE.md](ARCHITECTURE.md)
- Read [API_REFERENCE.md](API_REFERENCE.md)
- Contact the maintainers

---

## Recognition

Contributors are recognized in:

- [CONTRIBUTORS.md](CONTRIBUTORS.md) (maintained)
- GitHub contribution graph
- Release notes

Thank you for contributing to E-WMS!

---

**Last Updated**: May 6, 2026  
**Maintainers**: [Development Team]
