from fastapi import APIRouter, HTTPException, Depends, Header
import jwt
from sqlalchemy.orm import Session
from models.user_model import UserModel
from schemas.user_schema import UserCreate, UserLogin
from database.init import get_db
from middlewares.auth_middleware import auth_middleware
from utilities.security_pass import hash_password
import bcrypt
import uuid

router = APIRouter()


@router.post("/signup", status_code=200)
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    """
    Create a new user account with the provided credentials. This endpoint registers a new user in the system after validating that the email is not already registered and that the password and confirmation password match. The password is hashed before being stored in the database.

    Args:
        user(UserCreate): User creation schema containing:
            - fname (str): First name of the user
            - lname (str): Last name of the user
            - email (str): Email address of the user
            - mobnum (str): Mobile number of the user
            - password (str): Password for the account
            - conpassword (str): Password confirmation
        db(Session):
            - Database session dependency for performing database operations

    Returns:
        UserModel:
            - The newly created user object from the database
    Raises:
        HTTPException:
            - status_code 400: If the email is already registered
            - status_code 400: If password and confirmation password do not match
    """
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


@router.post("/signin", status_code=200)
def signin_user(user: UserLogin, db: Session = Depends(get_db)):
    """
    Authenticate a user and generate a JWT token.
    Args:
        user(UserLogin):
            - User login credentials containing email and password.
        db(Session):
            - Database session dependency.

    Returns:
        dict: A dictionary containing:
            - token(str): JWT token for authenticated user.
            - user(UserModel): Authenticated user object.

    Raises:
        - HTTPException: If email doesn't exist (status_code 400).
        - HTTPException: If password is invalid (status_code 400).
    """
    login_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    if not login_user:
        raise HTTPException(status_code=400, detail="Email Doesn't Exists!")

    if not bcrypt.checkpw(user.password.encode("utf-8"), login_user.password):  # type: ignore
        raise HTTPException(status_code=400, detail="Invalid Password!")

    token = jwt.encode({"id": login_user.id}, "password_key")

    return {"token": token, "user": login_user}


@router.get("/profile", status_code=200)
def current_user_data(
    db: Session = Depends(get_db), user_dict=Depends(auth_middleware)
):
    """
    Retrieve the current authenticated user's profile data. This endpoint fetches the profile information of the currently authenticated user by querying the database using the user ID from the authentication middleware.

    Args:
        db(Session):
            - Database session dependency for querying the database.
        user_dict(dict):
            - Dictionary containing authenticated user information,
            injected by auth_middleware. Expected to contain 'uid' key
            with the user's unique identifier.

    Returns:
        UserModel:
            - The user object containing profile information.

    Raises:
        HTTPException:
            - 404 error if the user is not found in the database.

    Status Code:
        200: Successfully retrieved user profile data.
    """
    user = db.query(UserModel).filter(UserModel.id == user_dict["uid"]).first()

    if not user:
        raise HTTPException(status_code=404, detail="User Not Found!")

    return user
