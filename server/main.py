from fastapi import FastAPI
from database.init import Engine
from models.base import BASE
from routers import user_router
from routers import landing_router

# Initialize database
BASE.metadata.create_all(bind=Engine)

# Create FastAPI app
app = FastAPI(title="User Management API", version="1.0.0")

# Include Routers
app.include_router(user_router.router, prefix="/auth")
app.include_router(landing_router.router)


@app.get("/")
def AuthService():
    return {"message": "E-Disposal Government Application API Services"}
