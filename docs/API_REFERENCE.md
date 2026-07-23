# E-WMS API Reference Guide

## Complete API Endpoint Documentation

**API Version**: 1.0.0  
**Base URL**: `http://localhost:8000` (Development) or `https://api.example.com` (Production)  
**Authentication**: JWT Bearer Token  
**Response Format**: JSON

---

## Table of Contents

1. [Authentication Endpoints](#authentication-endpoints)
2. [Task Management Endpoints](#task-management-endpoints)
3. [Location Endpoints](#location-endpoints)
4. [News Endpoints](#news-endpoints)
5. [Announcement Endpoints](#announcement-endpoints)
6. [Error Handling](#error-handling)
7. [Common Response Formats](#common-response-formats)
8. [Authentication Guide](#authentication-guide)

---

## Authentication Endpoints

### Overview

Authentication endpoints manage user registration, login, and token management.

---

### 1. User Sign-Up

**Endpoint**: `POST /auth/signup`

**Description**: Register a new user account in the system.

**Request Headers**:

```
Content-Type: application/json
```

**Request Body**:

```json
{
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "mobnum": "+1234567890",
    "password": "SecurePassword123!",
    "conpassword": "SecurePassword123!"
}
```

**Request Fields**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| fname | string | Yes | First name (max 20 characters) |
| lname | string | Yes | Last name (max 20 characters) |
| email | string | Yes | Email address (must be unique) |
| mobnum | string | No | Mobile number |
| password | string | Yes | Account password (min 8 characters) |
| conpassword | string | Yes | Password confirmation (must match password) |

**Success Response (200 OK)**:

```json
{
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "mobnum": "+1234567890",
    "message": "User created successfully"
}
```

**Error Responses**:

**400 Bad Request** - Validation failed:

```json
{
    "detail": "Email already registered"
}
```

**400 Bad Request** - Password mismatch:

```json
{
    "detail": "Passwords do not match"
}
```

**422 Unprocessable Entity** - Invalid data:

```json
{
    "detail": [
        {
            "loc": ["body", "email"],
            "msg": "invalid email format",
            "type": "value_error.email"
        }
    ]
}
```

**cURL Example**:

```bash
curl -X POST http://localhost:8000/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "mobnum": "+1234567890",
    "password": "SecurePassword123!",
    "conpassword": "SecurePassword123!"
  }'
```

**Python Example**:

```python
import requests

payload = {
    "fname": "John",
    "lname": "Doe",
    "email": "john.doe@example.com",
    "mobnum": "+1234567890",
    "password": "SecurePassword123!",
    "conpassword": "SecurePassword123!"
}

response = requests.post(
    "http://localhost:8000/auth/signup",
    json=payload
)
print(response.json())
```

---

### 2. User Sign-In

**Endpoint**: `POST /auth/signin`

**Description**: Authenticate user and receive JWT access token.

**Request Headers**:

```
Content-Type: application/json
```

**Request Body**:

```json
{
    "email": "john.doe@example.com",
    "password": "SecurePassword123!"
}
```

**Request Fields**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| email | string | Yes | Registered email address |
| password | string | Yes | Account password |

**Success Response (200 OK)**:

```json
{
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "token_type": "bearer",
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "expires_in": 1800
}
```

**Response Fields**:

| Field | Type | Description |
|-------|------|-------------|
| access_token | string | JWT token for authentication |
| token_type | string | Token type (always "bearer") |
| user_id | string | Authenticated user ID |
| expires_in | integer | Token expiration time in seconds |

**Error Responses**:

**401 Unauthorized** - Invalid credentials:

```json
{
    "detail": "Invalid email or password"
}
```

**404 Not Found** - User not found:

```json
{
    "detail": "User not found"
}
```

**cURL Example**:

```bash
curl -X POST http://localhost:8000/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john.doe@example.com",
    "password": "SecurePassword123!"
  }'
```

**Dart/Flutter Example**:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> signIn(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:8000/auth/signin'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data['access_token'];
    // Store token in SharedPreferences
  } else {
    throw Exception('Sign-in failed');
  }
}
```

---

## Task Management Endpoints

### Overview

Task endpoints manage disposal tasks and their status.

---

### 3. Create Task

**Endpoint**: `POST /task-data`

**Description**: Create a new disposal task.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body**:

```json
{
    "title": "Clean Disposal Site A",
    "description": "Collect and sort electronic waste at location A",
    "priority": "HIGH",
    "status": "PENDING",
    "due_date": "2026-05-20T14:30:00"
}
```

**Request Fields**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| title | string | Yes | Task title (must be unique) |
| description | string | No | Detailed task description |
| priority | string | Yes | Priority level: LOW, MEDIUM, HIGH, CRITICAL |
| status | string | Yes | Task status: PENDING, IN_PROGRESS, COMPLETED, CANCELLED |
| due_date | datetime | Yes | Task due date in ISO 8601 format |

**Success Response (200 OK)**:

```json
{
    "id": "550e8400-e29b-41d4-a716-446655440001",
    "title": "Clean Disposal Site A",
    "description": "Collect and sort electronic waste at location A",
    "priority": "HIGH",
    "status": "PENDING",
    "due_date": "2026-05-20T14:30:00",
    "created_at": "2026-05-06T10:15:30"
}
```

**Error Responses**:

**400 Bad Request** - Duplicate title:

```json
{
    "detail": "Task with this title already exists"
}
```

**401 Unauthorized** - Invalid token:

```json
{
    "detail": "Not authenticated"
}
```

**422 Unprocessable Entity** - Invalid data:

```json
{
    "detail": [
        {
            "loc": ["body", "priority"],
            "msg": "value is not a valid enumeration member",
            "type": "type_error.enum"
        }
    ]
}
```

**cURL Example**:

```bash
curl -X POST http://localhost:8000/task-data \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGc..." \
  -d '{
    "title": "Clean Disposal Site A",
    "description": "Collect and sort electronic waste at location A",
    "priority": "HIGH",
    "status": "PENDING",
    "due_date": "2026-05-20T14:30:00"
  }'
```

---

### 4. Get All Tasks

**Endpoint**: `GET /task-data`

**Description**: Retrieve all tasks in the system.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Authorization: Bearer <access_token>
```

**Query Parameters**:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| status | string | No | Filter by status (PENDING, IN_PROGRESS, etc.) |
| priority | string | No | Filter by priority (LOW, MEDIUM, HIGH, CRITICAL) |
| skip | integer | No | Number of tasks to skip (pagination) |
| limit | integer | No | Maximum tasks to return (pagination) |

**Success Response (200 OK)**:

```json
[
    {
        "id": "550e8400-e29b-41d4-a716-446655440001",
        "title": "Clean Disposal Site A",
        "description": "Collect and sort electronic waste",
        "priority": "HIGH",
        "status": "PENDING",
        "due_date": "2026-05-20T14:30:00",
        "created_at": "2026-05-06T10:15:30"
    },
    {
        "id": "550e8400-e29b-41d4-a716-446655440002",
        "title": "Categorize E-Waste",
        "description": "Sort collected waste by category",
        "priority": "MEDIUM",
        "status": "IN_PROGRESS",
        "due_date": "2026-05-22T15:00:00",
        "created_at": "2026-05-06T10:20:00"
    }
]
```

**Empty Response (200 OK)**:

```json
[]
```

**Error Responses**:

**401 Unauthorized** - Invalid token:

```json
{
    "detail": "Not authenticated"
}
```

**cURL Example**:

```bash
curl -X GET "http://localhost:8000/task-data?priority=HIGH&status=PENDING" \
  -H "Authorization: Bearer eyJhbGc..."
```

**Dart/Flutter Example**:

```dart
Future<List<Task>> getTasks(String token) async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/task-data'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((task) => Task.fromJson(task)).toList();
  } else {
    throw Exception('Failed to load tasks');
  }
}
```

---

## Location Endpoints

### Overview

Location endpoints manage disposal site locations and their status.

---

### 5. Get Locations

**Endpoint**: `GET /location`

**Description**: Retrieve all disposal site locations.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Authorization: Bearer <access_token>
```

**Success Response (200 OK)**:

```json
[
    {
        "markerId": "loc-001",
        "latitude": 40.7128,
        "longitude": -74.0060,
        "isFull": false
    },
    {
        "markerId": "loc-002",
        "latitude": 34.0522,
        "longitude": -118.2437,
        "isFull": true
    },
    {
        "markerId": "loc-003",
        "latitude": 41.8781,
        "longitude": -87.6298,
        "isFull": false
    }
]
```

**Response Fields**:

| Field | Type | Description |
|-------|------|-------------|
| markerId | string | Unique location identifier |
| latitude | float | Latitude coordinate |
| longitude | float | Longitude coordinate |
| isFull | boolean | Whether location is full |

**Error Responses**:

**401 Unauthorized** - Invalid token:

```json
{
    "detail": "Not authenticated"
}
```

**cURL Example**:

```bash
curl -X GET http://localhost:8000/location \
  -H "Authorization: Bearer eyJhbGc..."
```

---

### 6. Create Location

**Endpoint**: `POST /location`

**Description**: Add a new disposal site location.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body**:

```json
{
    "markerId": "loc-004",
    "latitude": 37.7749,
    "longitude": -122.4194,
    "isFull": false
}
```

**Request Fields**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| markerId | string | Yes | Unique location identifier |
| latitude | float | Yes | Latitude coordinate (-90 to 90) |
| longitude | float | Yes | Longitude coordinate (-180 to 180) |
| isFull | boolean | Yes | Whether location capacity is full |

**Success Response (200 OK)**:

```json
{
    "markerId": "loc-004",
    "latitude": 37.7749,
    "longitude": -122.4194,
    "isFull": false
}
```

**Error Responses**:

**400 Bad Request** - Duplicate markerId:

```json
{
    "detail": "Location with this markerId already exists"
}
```

**422 Unprocessable Entity** - Invalid coordinates:

```json
{
    "detail": [
        {
            "loc": ["body", "latitude"],
            "msg": "ensure this value is less than or equal to 90",
            "type": "value_error.number.not_le"
        }
    ]
}
```

**cURL Example**:

```bash
curl -X POST http://localhost:8000/location \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer eyJhbGc..." \
  -d '{
    "markerId": "loc-004",
    "latitude": 37.7749,
    "longitude": -122.4194,
    "isFull": false
  }'
```

---

## News Endpoints

### Overview

News endpoints manage system news articles.

---

### 7. Get News

**Endpoint**: `GET /news-data`

**Description**: Retrieve all news articles.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Authorization: Bearer <access_token>
```

**Success Response (200 OK)**:

```json
[
    {
        "id": "550e8400-e29b-41d4-a716-446655440010",
        "title": "New Waste Management Policy",
        "description": "Updated guidelines for electronic waste disposal...",
        "due_date": "2026-05-30T00:00:00",
        "created_at": "2026-05-06T10:00:00"
    },
    {
        "id": "550e8400-e29b-41d4-a716-446655440011",
        "title": "Facility Expansion Announced",
        "description": "New disposal facility opening next month...",
        "due_date": "2026-06-01T00:00:00",
        "created_at": "2026-05-05T14:30:00"
    }
]
```

**cURL Example**:

```bash
curl -X GET http://localhost:8000/news-data \
  -H "Authorization: Bearer eyJhbGc..."
```

---

### 8. Create News

**Endpoint**: `POST /news-data`

**Description**: Create a new news article.

**Authentication Required**: Yes (JWT Token - Admin only)

**Request Headers**:

```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body**:

```json
{
    "title": "Updated Regulations",
    "description": "New electronic waste handling regulations effective immediately...",
    "due_date": "2026-06-15T00:00:00"
}
```

**Success Response (200 OK)**:

```json
{
    "id": "550e8400-e29b-41d4-a716-446655440012",
    "title": "Updated Regulations",
    "description": "New electronic waste handling regulations effective immediately...",
    "due_date": "2026-06-15T00:00:00",
    "created_at": "2026-05-06T11:20:00"
}
```

---

## Announcement Endpoints

### Overview

Announcement endpoints manage system announcements.

---

### 9. Get Announcements

**Endpoint**: `GET /announcement-data`

**Description**: Retrieve all announcements.

**Authentication Required**: Yes (JWT Token)

**Request Headers**:

```
Authorization: Bearer <access_token>
```

**Success Response (200 OK)**:

```json
[
    {
        "id": "550e8400-e29b-41d4-a716-446655440020",
        "title": "Scheduled Maintenance",
        "description": "System maintenance scheduled for May 10, 2026 from 2-4 AM UTC",
        "due_date": "2026-05-10T06:00:00",
        "created_at": "2026-05-06T09:00:00"
    },
    {
        "id": "550e8400-e29b-41d4-a716-446655440021",
        "title": "Data Backup Reminder",
        "description": "Please ensure your data is backed up before the maintenance window",
        "due_date": "2026-05-10T06:00:00",
        "created_at": "2026-05-06T09:05:00"
    }
]
```

**cURL Example**:

```bash
curl -X GET http://localhost:8000/announcement-data \
  -H "Authorization: Bearer eyJhbGc..."
```

---

### 10. Create Announcement

**Endpoint**: `POST /announcement-data`

**Description**: Create a new announcement.

**Authentication Required**: Yes (JWT Token - Admin only)

**Request Headers**:

```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body**:

```json
{
    "title": "Service Update",
    "description": "We are upgrading our systems to provide better service...",
    "due_date": "2026-05-15T12:00:00"
}
```

**Success Response (200 OK)**:

```json
{
    "id": "550e8400-e29b-41d4-a716-446655440022",
    "title": "Service Update",
    "description": "We are upgrading our systems to provide better service...",
    "due_date": "2026-05-15T12:00:00",
    "created_at": "2026-05-06T11:50:00"
}
```

---

## Error Handling

### HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request succeeded |
| 201 | Created | Resource created successfully |
| 400 | Bad Request | Invalid request parameters |
| 401 | Unauthorized | Authentication required or invalid |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 422 | Unprocessable Entity | Validation error |
| 500 | Internal Server Error | Server-side error |
| 503 | Service Unavailable | Server temporarily unavailable |

### Error Response Format

**Standard Error Response**:

```json
{
    "detail": "Descriptive error message"
}
```

**Validation Error Response**:

```json
{
    "detail": [
        {
            "loc": ["body", "email"],
            "msg": "invalid email format",
            "type": "value_error.email"
        },
        {
            "loc": ["body", "password"],
            "msg": "ensure this value has at least 8 characters",
            "type": "value_error.string.min_length"
        }
    ]
}
```

### Common Error Codes

| Error | Status | Description | Solution |
|-------|--------|-------------|----------|
| Not authenticated | 401 | Missing or invalid token | Include valid JWT in Authorization header |
| Invalid email | 422 | Malformed email | Provide valid email format |
| Passwords do not match | 400 | Password mismatch | Ensure both passwords are identical |
| Email already registered | 400 | Duplicate email | Use different email or login |
| Task with this title already exists | 400 | Duplicate task | Use unique task title |
| Invalid credentials | 401 | Wrong password | Verify credentials and try again |

---

## Common Response Formats

### Success Response Wrapper

```json
{
    "status": "success",
    "data": {
        // Response data
    },
    "timestamp": "2026-05-06T12:00:00Z"
}
```

### Paginated Response (Future Implementation)

```json
{
    "data": [...],
    "pagination": {
        "total": 100,
        "page": 1,
        "per_page": 20,
        "total_pages": 5
    }
}
```

---

## Authentication Guide

### JWT Token Structure

A JWT token consists of three parts separated by dots:

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.
eyJzdWIiOiI1NTBlODQwMC1lMjliLTQxZDQtYTcxNi00NDY2NTU0NDAwMDAiLCJpYXQiOjE2NjcwODU4NDgsImV4cCI6MTY2NzA4OTQ0OH0.
uAI8rLhTvqJc8qqg3Q1Z8Ip5qJ5Z5Z5Z5Z5Z5Z5Z5Z0
```

1. **Header**: Algorithm and token type
2. **Payload**: User information and expiration
3. **Signature**: Cryptographic verification

### Using JWT in Requests

**Authorization Header Format**:

```
Authorization: Bearer <token>
```

**Example**:

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI...
```

### Token Management

**Storing Token (Flutter)**:

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Store token
final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', token);

// Retrieve token
final token = prefs.getString('auth_token');

// Delete token (logout)
await prefs.remove('auth_token');
```

**Token Refresh (Future Implementation)**:

```
POST /auth/refresh
Authorization: Bearer <refresh_token>
```

---

## Rate Limiting

**Current Limits** (Subject to change):

- Authentication endpoints: 10 requests per minute
- Regular endpoints: 100 requests per minute
- Burst limit: 200 requests per minute

**Rate Limit Headers** (Future):

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1620000000
```

---

## Versioning

**Current Version**: 1.0.0

Future API versions will be accessible via:

```
/api/v2/...
```

Legacy versions will be supported for 12 months.

---

## Webhooks (Future)

Planned webhook events:

- `task.created`
- `task.updated`
- `task.completed`
- `announcement.published`
- `location.updated`

---

This API Reference provides comprehensive documentation for integrating with the E-WMS backend. For additional support, refer to the main README.md or contact the development team.
