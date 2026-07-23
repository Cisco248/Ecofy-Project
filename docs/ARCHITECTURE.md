# E-WMS System Architecture Documentation

## Table of Contents

1. [System Overview](#system-overview)
2. [Architecture Layers](#architecture-layers)
3. [Component Interaction](#component-interaction)
4. [Data Flow](#data-flow)
5. [Deployment Architecture](#deployment-architecture)
6. [Technology Justification](#technology-justification)

---

## System Overview

The E-WMS system follows a **three-tier client-server architecture** with clear separation of concerns:

```sh
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│              (Flutter Mobile Application)                │
└─────────────────┬───────────────────────────────────────┘
                  │ HTTP/REST API Calls
                  ↓
┌─────────────────────────────────────────────────────────┐
│                    Application Layer                     │
│              (FastAPI Backend Server)                    │
│          ┌──────────────────────────────────┐           │
│          │   Routers / Controllers           │           │
│          │   • Authentication                │           │
│          │   • Task Management               │           │
│          │   • Location Services             │           │
│          │   • News & Announcements          │           │
│          └──────────────────────────────────┘           │
└─────────────────┬───────────────────────────────────────┘
                  │ SQL Queries
                  ↓
┌─────────────────────────────────────────────────────────┐
│                    Data Layer                            │
│              (PostgreSQL Database)                       │
│          ┌──────────────────────────────────┐           │
│          │   Relational Database Tables     │           │
│          │   • Users                         │           │
│          │   • Tasks                         │           │
│          │   • News                          │           │
│          │   • Announcements                 │           │
│          │   • Locations                     │           │
│          └──────────────────────────────────┘           │
└─────────────────────────────────────────────────────────┘
```

---

## Architecture Layers

### 1. Presentation Layer (Frontend - Flutter)

**Purpose**: User interface and user experience

**Components**:

- **UI Widgets**: Material Design 3 based widgets
- **Feature Modules**: Self-contained feature implementations
- **State Management**: Riverpod for reactive state
- **Local Storage**: SharedPreferences for caching
- **HTTP Client**: Built-in http package

**Key Responsibilities**:

- Render UI components
- Handle user interactions
- Manage local application state
- Cache data locally for offline access
- Validate user inputs before submission

**Architecture Pattern**: **MVVM (Model-View-ViewModel)**

```sh
View (UI Widget)
    ↓ binds to
ViewModel (Riverpod Provider)
    ↓ uses
Model (Data Classes & Logic)
    ↓ communicates with
API Service (HTTP Client)
```

### 2. Application Layer (Backend - FastAPI)

**Purpose**: Business logic and API endpoints

**Components**:

#### a) **Routers (Controllers)**

- `user_router.py`: Authentication endpoints
- `landing_router.py`: Task, news, announcement endpoints
- `location_router.py`: Location management endpoints

**Request Flow**:

```sh
HTTP Request
    ↓
Route Handler (Router)
    ↓ validates
Pydantic Schema
    ↓ processes
Business Logic
    ↓ interacts with
SQLAlchemy ORM
    ↓ executes
SQL Queries
    ↓
HTTP Response
```

#### b) **Middleware**

- **Authentication Middleware**: JWT token validation
- Ensures requests are authenticated
- Extracts user information from tokens

#### c) **Services/Utilities**

- `security_pass.py`: Password hashing and verification
- Security-related operations

### 3. Data Layer (Database - PostgreSQL)

**Purpose**: Persistent data storage

**Database Design**:

- **Relational schema** with normalized tables
- **Indexes** on frequently queried columns (email, id)
- **Foreign keys** for data integrity (if implemented)
- **Timestamps** for audit trail

**Tables**:

```sh
┌─────────────────────────────────────────────┐
│                    USERS                    │
├─────────────────────────────────────────────┤
│ id (PK)     │ fname │ lname │ email │ ...  │
└─────────────────────────────────────────────┘

┌─────────────────────────────────────────────┐
│                    TASKS                    │
├─────────────────────────────────────────────┤
│ id (PK) │ title │ description │ status │... │
└─────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│                    NEWS                      │
├──────────────────────────────────────────────┤
│ id (PK) │ title │ description │ created_at  │
└──────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│              ANNOUNCEMENTS                   │
├──────────────────────────────────────────────┤
│ id (PK) │ title │ description │ created_at  │
└──────────────────────────────────────────────┘

┌──────────────────────────────────────────────┐
│                LOCATIONS                     │
├──────────────────────────────────────────────┤
│ markerId(PK) │ latitude │ longitude │ isFull │
└──────────────────────────────────────────────┘
```

---

## Component Interaction

### 1. Authentication Flow

```sh
Mobile App (Login Screen)
    ↓ POST /auth/signin
FastAPI Router (user_router.py)
    ↓ validates credentials
Security Utility (bcrypt.compare)
    ↓ generates JWT
Returns JWT Token
    ↓
Mobile App (SharedPreferences)
    ↓ stores token
Subsequent Requests (Authorization Header)
    ↓
Auth Middleware (validates JWT)
    ↓
Route Handler (processes request)
```

### 2. Task Management Flow

```sh
Mobile App (Task List View)
    ↓ GET /task-data (with JWT)
Landing Router (landing_router.py)
    ↓ validates token
Auth Middleware (passes request)
    ↓
Route Handler
    ↓ queries database
SQLAlchemy ORM
    ↓ builds SQL
PostgreSQL Database
    ↓ returns data
    ↓
Response JSON
    ↓
Mobile App (Riverpod Provider)
    ↓ updates state
    ↓
UI Rebuilds (reactive)
```

### 3. Location Services Flow

```sh
Mobile App (Discover Screen)
    ↓ requests location data
Location Router (location_router.py)
    ↓
Database Query
    ↓
Locations Data
    ↓
Mobile App (Riverpod Provider)
    ↓ stores in state
    ↓
Google Maps Widget
    ↓ renders markers
    ↓
User Views Map
```

---

## Data Flow

### Complete Request-Response Cycle

```sh
┌─────────────────────────────────────────────────────────────┐
│                  CLIENT SIDE (Flutter)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. User Action (UI Interaction)                            │
│     ↓                                                        │
│  2. Riverpod Provider Method Called                         │
│     ↓                                                        │
│  3. HTTP Request Built                                      │
│     - URL: http://api/endpoint                              │
│     - Method: GET/POST/PUT/DELETE                           │
│     - Headers: Authorization: Bearer <token>                │
│     - Body: JSON data                                       │
│     ↓                                                        │
│  4. Request Sent via http Package                           │
│                                                              │
└─────────────────────────────────┬───────────────────────────┘
                                  │ Network
                                  ↓
┌─────────────────────────────────────────────────────────────┐
│                  SERVER SIDE (FastAPI)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Request Received                                         │
│     ↓                                                        │
│  2. Auth Middleware                                         │
│     - Checks Authorization header                           │
│     - Validates JWT token                                   │
│     - Extracts user information                             │
│     ↓                                                        │
│  3. Router Identifies Handler                               │
│     ↓                                                        │
│  4. Pydantic Schema Validation                              │
│     - Validates request body structure                      │
│     - Type checking                                         │
│     - Custom validators                                     │
│     ↓                                                        │
│  5. Business Logic Execution                                │
│     - Data processing                                       │
│     - Permission checks                                     │
│     - Complex operations                                    │
│     ↓                                                        │
│  6. Database Operations (ORM)                               │
│     - SQLAlchemy builds SQL                                │
│     - Parameterized queries (SQL injection safe)           │
│     ↓                                                        │
│  7. PostgreSQL Execution                                    │
│     - SQL Query execution                                   │
│     - Data retrieval/modification                          │
│     ↓                                                        │
│  8. Response Building                                       │
│     - Serialize models to JSON                             │
│     - Set HTTP status code                                 │
│     ↓                                                        │
│  9. Response Sent                                           │
│                                                              │
└─────────────────────────────────┬───────────────────────────┘
                                  │ Network
                                  ↓
┌─────────────────────────────────────────────────────────────┐
│                  CLIENT SIDE (Flutter)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Response Received                                        │
│     ↓                                                        │
│  2. Status Code Check                                       │
│     - 200-299: Success                                      │
│     - 400-499: Client error                                 │
│     - 500+: Server error                                    │
│     ↓                                                        │
│  3. JSON Parsing                                            │
│     ↓                                                        │
│  4. State Update (Riverpod)                                 │
│     ↓                                                        │
│  5. Local Cache Update (SharedPreferences)                  │
│     ↓                                                        │
│  6. UI Rebuild (Reactive)                                   │
│     ↓                                                        │
│  7. User Sees Updated UI                                    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Deployment Architecture

### Development Environment

```sh
Developer Machine
├── Flutter (Mobile Dev)
│   ├── Android Emulator/Device
│   ├── iOS Simulator/Device
│   └── Web Browser
├── VS Code/Android Studio
└── FastAPI Backend (Local)
    ├── Python Virtual Environment
    ├── PostgreSQL Database (Local)
    └── Uvicorn Server (localhost:8000)
```

### Production Environment

```sh
┌──────────────────────────────┐
│     User Devices             │
│  ├── Android Phones          │
│  ├── iOS Devices             │
│  └── Web Browsers            │
└──────────────────┬───────────┘
                   │ HTTPS
                   ↓
┌──────────────────────────────────────┐
│     Cloud Provider (AWS/GCP/Azure)   │
├──────────────────────────────────────┤
│                                      │
│  ┌────────────────────────────────┐ │
│  │    Load Balancer (Optional)    │ │
│  └────────────┬───────────────────┘ │
│               │                      │
│  ┌────────────┴────────────────┐   │
│  │    Docker Container         │   │
│  │  ┌──────────────────────┐  │   │
│  │  │   FastAPI Server     │  │   │
│  │  │   uvicorn            │  │   │
│  │  └──────────────────────┘  │   │
│  └────────────┬────────────────┘   │
│               │                    │
│  ┌────────────▼────────────────┐  │
│  │   PostgreSQL Database       │  │
│  │   (Managed or Containerized)│  │
│  └─────────────────────────────┘  │
│                                    │
│  Monitoring & Logging             │
│  ├── CloudWatch/Stackdriver       │
│  ├── Error Tracking               │
│  └── Performance Metrics          │
└──────────────────────────────────────┘
```

### Docker Compose Setup

```sh
docker-compose.yml
├── Service: PostgreSQL Database
│   ├── Image: postgres:15-alpine
│   ├── Port: 5433
│   ├── Health Check: Active
│   └── Volume: postgres_data
│
└── Service: FastAPI Server
    ├── Build: ./server (Dockerfile)
    ├── Port: 8000
    ├── Dependencies: db (health check)
    ├── Environment: DATABASE_URL, etc.
    └── Volume: ./server (development reload)
```

---

## Technology Justification

### Why Flutter?

| Aspect | Benefit |
|--------|---------|

| **Cross-Platform** | One codebase for Android, iOS, Web, Desktop |
| **Performance** | Compiled to native code, excellent performance |
| **UI Framework** | Material Design 3 for modern UI |
| **Developer Experience** | Hot reload for rapid development |
| **Community** | Large community and many packages available |
| **Firebase Integration** | Easy integration with Firebase services |

### Why FastAPI?

| Aspect | Benefit |
|--------|---------|

| **Performance** | One of the fastest Python frameworks |
| **Type Hints** | Built-in support for Python type hints |
| **Auto Documentation** | Automatic OpenAPI/Swagger documentation |
| **Validation** | Pydantic for robust input validation |
| **Modern Python** | Uses async/await for concurrency |
| **Easy to Learn** | Simple and intuitive API design |
| **Production Ready** | Used in production by many companies |

### Why PostgreSQL?

| Aspect | Benefit |
|--------|---------|

| **Reliability** | ACID compliance, data integrity |
| **Features** | Advanced data types, JSON support |
| **Scalability** | Handles large datasets efficiently |
| **Open Source** | No licensing costs, community support |
| **Security** | Strong authentication and encryption support |
| **Performance** | Excellent query optimization |

### Why Riverpod?

| Aspect | Benefit |
|--------|---------|

| **Modern** | Latest state management approach in Flutter |
| **Type-Safe** | Strong type checking at compile time |
| **Testable** | Easy to test with dependency injection |
| **Performance** | Only rebuilds affected widgets |
| **Code Generation** | Automatic code generation with build_runner |

### Why Docker?

| Aspect | Benefit |
|--------|---------|

| **Consistency** | Same environment across machines |
| **Isolation** | Services don't interfere with each other |
| **Easy Deployment** | Deploy anywhere Docker is available |
| **Scalability** | Easy to scale services horizontally |
| **Development** | Replicate production environment locally |

---

## Security Architecture

### Authentication Flow

```sh
┌─────────────────────────────┐
│   Credentials (User Input)  │
│   - Email                   │
│   - Password                │
└────────────┬────────────────┘
             │
             ↓
┌─────────────────────────────┐
│    Validation               │
│    - Email format           │
│    - Password strength      │
└────────────┬────────────────┘
             │
             ↓
┌─────────────────────────────┐
│    Hash Comparison          │
│    - bcrypt.compare()       │
│    - Stored password hash   │
└────────────┬────────────────┘
             │
             ├─ Match: Continue
             │
             └─ No Match: Return 401
                        ↓
            ┌──────────────────────┐
            │  Generate JWT Token  │
            │  - Header            │
            │  - Payload           │
            │  - Signature         │
            └──────────┬───────────┘
                       │
                       ↓
            ┌──────────────────────┐
            │  Return to Client    │
            │  - access_token      │
            │  - token_type        │
            │  - expires_in        │
            └──────────┬───────────┘
                       │
                       ↓
            ┌──────────────────────┐
            │  Client Storage      │
            │  (SharedPreferences) │
            └──────────┬───────────┘
                       │
                       ↓
         ┌─────────────────────────────┐
         │  Subsequent Requests        │
         │  Authorization: Bearer X.X.X│
         └──────────┬──────────────────┘
                    │
                    ↓
         ┌─────────────────────────────┐
         │  Server Validation          │
         │  - JWT Signature Check      │
         │  - Expiry Check             │
         │  - User Verification        │
         └──────────┬──────────────────┘
                    │
    ┌───────────────┼───────────────┐
    │ Valid         │ Invalid       │
    ↓               ↓
 Process      Return 401
 Request      Unauthorized
```

### Data Protection

1. **In Transit**: HTTPS/TLS (production)
2. **At Rest**: Database encryption (production)
3. **In Application**: Parameterized queries (ORM)
4. **Password Storage**: bcrypt hashing with salt

---

## Scalability Considerations

### Horizontal Scaling

```sh
              ┌─────────────────┐
              │  Load Balancer  │
              └────────┬────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ↓              ↓              ↓
    ┌─────────┐   ┌─────────┐   ┌─────────┐
    │FastAPI 1│   │FastAPI 2│   │FastAPI 3│
    └────┬────┘   └────┬────┘   └────┬────┘
         │             │             │
         └─────────────┼─────────────┘
                       │
                       ↓
            ┌──────────────────────┐
            │  PostgreSQL Database │
            │  (with replication)  │
            └──────────────────────┘
```

### Caching Strategy

```sh
Client Cache (SharedPreferences)
    ↓
Server-Side Cache (Redis) - Optional
    ↓
Database Query Cache
```

### Database Optimization

- Indexing on frequently queried fields
- Query optimization
- Connection pooling
- Read replicas for scaling reads

---

## Monitoring & Logging

### Logging Points

```sh
Request Entry
    ↓ [Log Request Details]
Auth Middleware
    ↓ [Log Authentication]
Route Handler
    ↓ [Log Business Logic]
Database Operations
    ↓ [Log Queries]
Response Generation
    ↓ [Log Response Status]
    ↓
Client
```

### Metrics to Monitor

- API response time
- Database query performance
- Error rates
- User authentication attempts
- System resource utilization

---

## Disaster Recovery

### Backup Strategy

1. **Database Backups**: Daily automated backups
2. **Code Repositories**: Git version control
3. **Configuration**: Environment variable management
4. **Data Redundancy**: Database replication

### Recovery Process

```sh
Issue Detected
    ↓
Backup Identified
    ↓
Service Stopped
    ↓
Database Restored
    ↓
Service Restarted
    ↓
Data Verification
    ↓
Service Online
```

---

This architecture provides a solid foundation for a scalable, secure, and maintainable e-WMS system.
