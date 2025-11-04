from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database.init import get_db
from schemas.user_schema import UserCreate
from models.user_model import UserModel


router = APIRouter()


@router.get("/profile")
def get_profile_data(user: UserCreate, db: Session = Depends(get_db)):
    user_data = db.query(UserModel).filter(UserModel.email == user.email).all()
    if user_data:
        return user_data
    else:
        raise HTTPException(status_code=400, detail="User Not Found")
