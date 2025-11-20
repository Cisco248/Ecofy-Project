from sqlalchemy import Column, Float, String, Boolean
from models.base import BASE


class LocationModel(BASE):
    __tablename__ = "location"

    markerId = Column(String, nullable=False, primary_key=True)
    latitude = Column(Float, nullable=False)
    longitude = Column(Float, nullable=False)
    isFull = Column(Boolean, nullable=False)
    hue = Column(Float, nullable=True)
