from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from models.user_model import UserModel
from schemas.user_schema import UserCreate, UserLogin
from database.init import get_db
from utilities.security_pass import hash_password
import bcrypt
import uuid

router = APIRouter()


@router.post("/signup", status_code=201)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).all()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email Already Registered!")

    if user.password != user.conpassword:
        raise HTTPException(status_code=400, detail="Passwords Doesn't Match!")

    hashed_pw = hash_password(user.password)

    new_user_db = UserModel(
        id=str(uuid.uuid4()),
        fname=user.fname,
        lname=user.lname,
        email=user.email,
        mobnum=user.mobnum,
        password=hashed_pw,
        conpassword=hashed_pw,
    )

    db.add(new_user_db)
    db.commit()
    db.refresh(new_user_db)

    return new_user_db


@router.post("/signin", status_code=201)
def signin_user(user: UserLogin, db: Session = Depends(get_db)):

    login_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    if not login_user:
        raise HTTPException(status_code=400, detail="Email Doesn't Exists!")

    if not bcrypt.checkpw(user.password.encode("utf-8"), login_user.password):  # type: ignore
        raise HTTPException(status_code=400, detail="Invalid Password!")

    return login_user
