import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Use correct PostgreSQL URL
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:root@127.0.0.1:5432/postgres")

# Create database engine
Engine = create_engine(DATABASE_URL, echo=False)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=Engine)


# Dependency for FastAPI routes
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
