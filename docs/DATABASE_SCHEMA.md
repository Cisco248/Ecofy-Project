# E-WMS Database Schema Documentation

## Complete Database Design and Schema Reference

---

## Table of Contents

1. [Database Overview](#database-overview)
2. [Table Schemas](#table-schemas)
3. [Relationships](#relationships)
4. [Indexing Strategy](#indexing-strategy)
5. [SQL Queries](#sql-queries)
6. [Constraints & Validation](#constraints--validation)
7. [Backup & Recovery](#backup--recovery)

---

## Database Overview

### Database Configuration

- **DBMS**: PostgreSQL 15
- **Database Name**: `fastapi_db`
- **Character Set**: UTF-8
- **Timezone**: UTC
- **Connection Pool**: 10-20 connections (configurable)

### Access Credentials (Development)

```
Host: localhost
Port: 5432 (local) or 5433 (Docker)
User: postgres
Password: postgres
Database: fastapi_db
```

### Database Connection String

```
postgresql://postgres:postgres@localhost:5432/fastapi_db
```

---

## Table Schemas

### 1. Users Table

**Purpose**: Store user account information and authentication details.

```sql
CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    mobnum VARCHAR(15),
    password BYTEA NOT NULL,
    conpassword BYTEA NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Field Descriptions**:

| Column | Type | Constraints | Description |
|--------|------|-----------|-------------|
| `id` | VARCHAR | PRIMARY KEY | Unique user identifier (UUID) |
| `fname` | VARCHAR(20) | NOT NULL | First name |
| `lname` | VARCHAR(20) | NOT NULL | Last name |
| `email` | VARCHAR(50) | UNIQUE, NOT NULL, INDEX | Email address (unique, indexed for login) |
| `mobnum` | VARCHAR(15) | NULLABLE | Mobile number |
| `password` | BYTEA | NOT NULL | Hashed password (bcrypt) |
| `conpassword` | BYTEA | NOT NULL | Confirmation password hash |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Account creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last profile update timestamp |

**Indexes**:

```sql
CREATE UNIQUE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_id ON users(id);
```

**Sample Data**:

```sql
INSERT INTO users VALUES 
(
    '550e8400-e29b-41d4-a716-446655440000',
    'John',
    'Doe',
    'john.doe@example.com',
    '+1234567890',
    E'\\x2412243031323334353637383930313233343536373839303132333435363738',  -- bcrypt hash
    E'\\x2412243031323334353637383930313233343536373839303132333435363738',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);
```

---

### 2. Tasks Table

**Purpose**: Store disposal task information and status.

```sql
CREATE TABLE tasks (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL UNIQUE,
    description VARCHAR,
    priority VARCHAR DEFAULT 'MEDIUM',
    status VARCHAR DEFAULT 'PENDING',
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Field Descriptions**:

| Column | Type | Constraints | Description |
|--------|------|-----------|-------------|
| `id` | VARCHAR | PRIMARY KEY | Unique task identifier (UUID) |
| `title` | VARCHAR | NOT NULL, UNIQUE | Task title (must be unique) |
| `description` | VARCHAR | NULLABLE | Detailed task description |
| `priority` | VARCHAR | DEFAULT 'MEDIUM' | Priority level: LOW, MEDIUM, HIGH, CRITICAL |
| `status` | VARCHAR | DEFAULT 'PENDING' | Status: PENDING, IN_PROGRESS, COMPLETED, CANCELLED |
| `due_date` | TIMESTAMP | NULLABLE | Task deadline |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Task creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last modification timestamp |

**Indexes**:

```sql
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_priority ON tasks(priority);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
```

**Valid Values**:

```sql
-- Priority levels
CHECK (priority IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL'))

-- Task status
CHECK (status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'))
```

**Sample Data**:

```sql
INSERT INTO tasks VALUES 
(
    '550e8400-e29b-41d4-a716-446655440001',
    'Clean Disposal Site A',
    'Collect and sort electronic waste at location A',
    'HIGH',
    'PENDING',
    '2026-05-20 14:30:00',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);
```

---

### 3. News Table

**Purpose**: Store news articles and updates.

```sql
CREATE TABLE news (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR,
    is_published BOOLEAN DEFAULT true
);
```

**Field Descriptions**:

| Column | Type | Constraints | Description |
|--------|------|-----------|-------------|
| `id` | VARCHAR | PRIMARY KEY | Unique news identifier (UUID) |
| `title` | VARCHAR | NOT NULL | News headline |
| `description` | VARCHAR | NULLABLE | Full article content |
| `due_date` | TIMESTAMP | NULLABLE | Publication deadline/display date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Article creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last edit timestamp |
| `created_by` | VARCHAR | NULLABLE | Author user ID (foreign key candidate) |
| `is_published` | BOOLEAN | DEFAULT true | Publication status |

**Indexes**:

```sql
CREATE INDEX idx_news_created_at ON news(created_at DESC);
CREATE INDEX idx_news_due_date ON news(due_date);
CREATE INDEX idx_news_is_published ON news(is_published);
```

**Sample Data**:

```sql
INSERT INTO news VALUES 
(
    '550e8400-e29b-41d4-a716-446655440010',
    'New Waste Management Policy',
    'Updated guidelines for electronic waste disposal have been announced...',
    '2026-05-30 00:00:00',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    '550e8400-e29b-41d4-a716-446655440000',
    true
);
```

---

### 4. Announcements Table

**Purpose**: Store system announcements and important notices.

```sql
CREATE TABLE announcements (
    id VARCHAR PRIMARY KEY,
    title VARCHAR NOT NULL,
    description VARCHAR,
    priority VARCHAR DEFAULT 'NORMAL',
    due_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR,
    is_active BOOLEAN DEFAULT true
);
```

**Field Descriptions**:

| Column | Type | Constraints | Description |
|--------|------|-----------|-------------|
| `id` | VARCHAR | PRIMARY KEY | Unique announcement ID (UUID) |
| `title` | VARCHAR | NOT NULL | Announcement title |
| `description` | VARCHAR | NULLABLE | Full announcement text |
| `priority` | VARCHAR | DEFAULT 'NORMAL' | Priority: LOW, NORMAL, HIGH, CRITICAL |
| `due_date` | TIMESTAMP | NULLABLE | Announcement expiry/target date |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last modification timestamp |
| `created_by` | VARCHAR | NULLABLE | Creator user ID |
| `is_active` | BOOLEAN | DEFAULT true | Whether announcement is currently active |

**Indexes**:

```sql
CREATE INDEX idx_announcements_is_active ON announcements(is_active);
CREATE INDEX idx_announcements_priority ON announcements(priority);
CREATE INDEX idx_announcements_created_at ON announcements(created_at DESC);
```

**Valid Values**:

```sql
CHECK (priority IN ('LOW', 'NORMAL', 'HIGH', 'CRITICAL'))
```

**Sample Data**:

```sql
INSERT INTO announcements VALUES 
(
    '550e8400-e29b-41d4-a716-446655440020',
    'System Maintenance Scheduled',
    'System maintenance scheduled for May 10, 2026 from 2-4 AM UTC',
    'HIGH',
    '2026-05-10 06:00:00',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    '550e8400-e29b-41d4-a716-446655440000',
    true
);
```

---

### 5. Locations Table

**Purpose**: Store disposal site locations with GPS coordinates.

```sql
CREATE TABLE location (
    markerId VARCHAR PRIMARY KEY NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    isFull BOOLEAN NOT NULL DEFAULT false,
    hue FLOAT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name VARCHAR,
    capacity INTEGER,
    current_load INTEGER DEFAULT 0
);
```

**Field Descriptions**:

| Column | Type | Constraints | Description |
|--------|------|-----------|-------------|
| `markerId` | VARCHAR | PRIMARY KEY, NOT NULL | Unique location identifier |
| `latitude` | FLOAT | NOT NULL | Latitude coordinate (-90 to 90) |
| `longitude` | FLOAT | NOT NULL | Longitude coordinate (-180 to 180) |
| `isFull` | BOOLEAN | NOT NULL, DEFAULT false | Whether location is at full capacity |
| `hue` | FLOAT | NULLABLE | Color hue for map marker (0-360) |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Location registration timestamp |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last status update timestamp |
| `name` | VARCHAR | NULLABLE | Location name/identifier |
| `capacity` | INTEGER | NULLABLE | Maximum capacity |
| `current_load` | INTEGER | DEFAULT 0 | Current waste load |

**Constraints**:

```sql
-- Validate coordinates
CHECK (latitude >= -90 AND latitude <= 90)
CHECK (longitude >= -180 AND longitude <= 180)
CHECK (hue >= 0 AND hue <= 360)
CHECK (current_load >= 0 AND current_load <= COALESCE(capacity, current_load))
```

**Indexes**:

```sql
CREATE INDEX idx_location_isFull ON location(isFull);
CREATE INDEX idx_location_coordinates ON location(latitude, longitude);
```

**Sample Data**:

```sql
INSERT INTO location VALUES 
(
    'loc-001',
    40.7128,
    -74.0060,
    false,
    120.5,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    'Manhattan Disposal Site',
    1000,
    450
);
```

---

## Relationships

### Entity Relationship Diagram

```
┌──────────────────────────────┐
│         USERS                │
├──────────────────────────────┤
│ id (PK)                      │
│ fname                        │
│ lname                        │
│ email (UNIQUE)               │
│ mobnum                       │
│ password                     │
│ conpassword                  │
│ created_at                   │
└──────────────────────────────┘
          ▲          ▲
          │          │
     (Future)   (Future)
          │          │
          │          │
    ┌─────┴──┬──────┴───────────────────────┐
    │        │                              │
┌───┴────────┴──┐              ┌────────────┴──┬───┐
│     TASKS     │              │     NEWS      │   │
├───────────────┤              ├───────────────┤   │
│ id (PK)       │              │ id (PK)       │   │
│ title (UNIQUE)│              │ title         │   │
│ description   │              │ description   │   │
│ priority      │              │ created_by*   │   │
│ status        │              │ is_published  │   │
│ due_date      │              │ created_at    │   │
│ created_at    │              └───────────────┘   │
└───────────────┘                                  │
                        ┌──────────────────────────┘
                        │
                   ┌────┴────────────────────────────┐
                   │                                 │
             ┌─────┴──────────┐         ┌────────────┴──────┐
             │ ANNOUNCEMENTS  │         │    LOCATION      │
             ├────────────────┤         ├──────────────────┤
             │ id (PK)        │         │ markerId (PK)    │
             │ title          │         │ latitude         │
             │ description    │         │ longitude        │
             │ priority       │         │ isFull           │
             │ created_by*    │         │ hue              │
             │ is_active      │         │ capacity         │
             │ created_at     │         │ current_load     │
             └────────────────┘         └──────────────────┘

* Future foreign key to users table
```

### Current Relationships

Currently, the schema is **normalized but not fully relational** (no foreign keys implemented). Future enhancements should include:

1. **Users → Tasks**: One user can create/own multiple tasks
2. **Users → News**: One user can create multiple news articles
3. **Users → Announcements**: One user can create multiple announcements

---

## Indexing Strategy

### Current Indexes

**Users Table**:

```sql
CREATE UNIQUE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_id ON users(id);
```

**Tasks Table**:

```sql
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_priority ON tasks(priority);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
```

**News Table**:

```sql
CREATE INDEX idx_news_created_at ON news(created_at DESC);
CREATE INDEX idx_news_is_published ON news(is_published);
```

**Announcements Table**:

```sql
CREATE INDEX idx_announcements_is_active ON announcements(is_active);
CREATE INDEX idx_announcements_priority ON announcements(priority);
```

**Locations Table**:

```sql
CREATE INDEX idx_location_isFull ON location(isFull);
CREATE INDEX idx_location_coordinates ON location(latitude, longitude);
```

### Recommended Additional Indexes

```sql
-- Composite index for common queries
CREATE INDEX idx_tasks_status_priority ON tasks(status, priority);
CREATE INDEX idx_news_published_date ON news(is_published, created_at DESC);
CREATE INDEX idx_announcements_active_priority ON announcements(is_active, priority DESC);

-- For range queries
CREATE INDEX idx_tasks_due_date_range ON tasks(due_date) WHERE status != 'COMPLETED';
```

### Index Performance Tips

1. **Monitor Index Usage**:

   ```sql
   SELECT * FROM pg_stat_user_indexes;
   ```

2. **Rebuild Indexes** (if fragmented):

   ```sql
   REINDEX INDEX idx_users_email;
   ```

3. **Analyze Query Plans**:

   ```sql
   EXPLAIN ANALYZE SELECT * FROM tasks WHERE status = 'PENDING';
   ```

---

## SQL Queries

### Common Query Patterns

#### 1. User Authentication

```sql
-- Find user by email
SELECT * FROM users WHERE email = 'john.doe@example.com';

-- Check if email exists
SELECT EXISTS(SELECT 1 FROM users WHERE email = $1) AS exists;
```

#### 2. Task Management

```sql
-- Get all pending tasks
SELECT * FROM tasks WHERE status = 'PENDING' ORDER BY due_date ASC;

-- Get high-priority tasks
SELECT * FROM tasks WHERE priority = 'HIGH' ORDER BY created_at DESC;

-- Count tasks by status
SELECT status, COUNT(*) FROM tasks GROUP BY status;

-- Tasks due within 7 days
SELECT * FROM tasks 
WHERE due_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
AND status != 'COMPLETED';
```

#### 3. Location Management

```sql
-- Find full locations
SELECT * FROM location WHERE isFull = true;

-- Get locations by capacity
SELECT * FROM location WHERE capacity > 500 ORDER BY current_load DESC;

-- Calculate location utilization
SELECT 
    markerId,
    name,
    ROUND(CAST(current_load AS FLOAT) / capacity * 100, 2) AS utilization_percent
FROM location
WHERE capacity IS NOT NULL
ORDER BY utilization_percent DESC;
```

#### 4. News & Announcements

```sql
-- Get recent published news
SELECT * FROM news 
WHERE is_published = true 
ORDER BY created_at DESC 
LIMIT 10;

-- Get active announcements
SELECT * FROM announcements 
WHERE is_active = true 
ORDER BY priority DESC, created_at DESC;

-- Get announcements expiring soon
SELECT * FROM announcements 
WHERE is_active = true 
AND due_date <= CURRENT_DATE + INTERVAL '3 days'
ORDER BY due_date ASC;
```

#### 5. Analytics & Reporting

```sql
-- Task completion rate
SELECT 
    DATE(created_at) AS date,
    COUNT(*) AS total_tasks,
    SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed,
    ROUND(
        SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END)::FLOAT / 
        COUNT(*) * 100, 
        2
    ) AS completion_percentage
FROM tasks
GROUP BY DATE(created_at)
ORDER BY date DESC;

-- Location capacity report
SELECT 
    CASE 
        WHEN isFull THEN 'Full'
        WHEN current_load > capacity * 0.8 THEN 'Near Capacity'
        ELSE 'Available'
    END AS status,
    COUNT(*) AS count,
    ROUND(AVG(CAST(current_load AS FLOAT) / capacity * 100), 2) AS avg_utilization
FROM location
WHERE capacity IS NOT NULL
GROUP BY status;
```

---

## Constraints & Validation

### Data Integrity

**Email Validation**:

```sql
-- Check valid email format
CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')
```

**Coordinate Validation**:

```sql
-- Latitude range
CHECK (latitude >= -90 AND latitude <= 90)

-- Longitude range
CHECK (longitude >= -180 AND longitude <= 180)
```

**Date Constraints**:

```sql
-- Due date must be in future
ALTER TABLE tasks ADD CHECK (due_date IS NULL OR due_date > created_at);

-- No future-dated records
ALTER TABLE tasks ADD CHECK (created_at <= CURRENT_TIMESTAMP);
```

**Enum Constraints**:

```sql
-- Priority levels
ALTER TABLE tasks ADD CHECK (priority IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL'));

-- Task status
ALTER TABLE tasks ADD CHECK (status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'));
```

### Application-Level Validation

Handled by **Pydantic schemas** in FastAPI:

- Email format validation
- Password strength requirements
- Coordinate range validation
- Enum value checking

---

## Backup & Recovery

### Backup Strategy

**Daily Automated Backup**:

```bash
# Backup entire database
pg_dump -U postgres -d fastapi_db > backup_$(date +%Y%m%d).sql

# Backup with compression
pg_dump -U postgres -d fastapi_db | gzip > backup_$(date +%Y%m%d).sql.gz

# Backup specific table
pg_dump -U postgres -d fastapi_db -t tasks > tasks_backup.sql
```

**Continuous Archiving** (Production):

```sql
-- Enable WAL archiving in postgresql.conf
wal_level = replica
archive_mode = on
archive_command = 'cp %p /backup/wal_archive/%f'
```

### Recovery Procedures

**Restore from Full Backup**:

```bash
# Drop and recreate database
psql -U postgres -c "DROP DATABASE IF EXISTS fastapi_db;"
psql -U postgres -c "CREATE DATABASE fastapi_db;"

# Restore from backup
psql -U postgres -d fastapi_db < backup_20260506.sql

# Or from compressed backup
gunzip < backup_20260506.sql.gz | psql -U postgres -d fastapi_db
```

**Restore Specific Table**:

```bash
psql -U postgres -d fastapi_db < tasks_backup.sql
```

**Point-in-Time Recovery** (with WAL):

```bash
# Stop PostgreSQL
sudo systemctl stop postgresql

# Restore base backup
# Restore WAL files from archive

# Start PostgreSQL
sudo systemctl start postgresql
```

### Backup Testing

```bash
# Schedule regular backup tests
# Monthly: Restore to test server and verify data integrity

# Verify backup integrity
pg_restore --validate backup.dump
```

---

## Schema Evolution

### Migration Tools

Use **Alembic** for database migrations:

```bash
# Initialize alembic
alembic init alembic

# Create migration
alembic revision --autogenerate -m "Add user_role column"

# Apply migrations
alembic upgrade head

# Rollback
alembic downgrade -1
```

### Common Migrations

**Add Column**:

```sql
ALTER TABLE tasks ADD COLUMN assigned_to UUID;
```

**Create Index**:

```sql
CREATE INDEX idx_tasks_assigned_to ON tasks(assigned_to);
```

**Add Foreign Key**:

```sql
ALTER TABLE tasks 
ADD CONSTRAINT fk_tasks_user_id 
FOREIGN KEY (assigned_to) REFERENCES users(id);
```

---

## Performance Tuning

### Query Optimization

**Analyze Query Plans**:

```sql
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM tasks WHERE status = 'PENDING' AND priority = 'HIGH';
```

**Identify Missing Indexes**:

```sql
SELECT * FROM pg_stat_user_indexes WHERE idx_scan = 0;
```

### Connection Pooling

Configure PgBouncer (development):

```ini
[databases]
fastapi_db = host=localhost port=5432 dbname=fastapi_db user=postgres

[pgbouncer]
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 25
```

### Vacuum & Analyze

```bash
# Daily maintenance
VACUUM ANALYZE;

# During off-peak hours
VACUUM FULL ANALYZE;
```

---

This database schema documentation provides a complete reference for understanding, maintaining, and extending the E-WMS database system.
