import uuid
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database.init import get_db
from models.location_model import LocationModel
from schemas.location_schema import LocationSchema


router = APIRouter()


@router.post("/bin-loc", status_code=200)
def add_loc(loc: LocationSchema, db: Session = Depends(get_db)):

    exist_loc = (
        db.query(LocationModel).filter(LocationModel.markerId == loc.markerId).first()
    )
    if exist_loc:
        raise HTTPException(status_code=400, detail="Location already added!")

    new_loc_db = LocationModel(
        markerId=loc.markerId,
        latitude=loc.latitude,
        longitude=loc.longitude,
        isFull=loc.isFull,
        hue=loc.hue,
    )

    db.add(new_loc_db)
    db.commit()
    db.refresh(new_loc_db)

    return new_loc_db


@router.get("/bin-loc", status_code=200)
def get_bin_data(db: Session = Depends(get_db)):

    exist_loc = db.query(LocationModel).all()

    if not exist_loc:
        raise HTTPException(status_code=400, detail="Location Not Found!")

    return exist_loc
