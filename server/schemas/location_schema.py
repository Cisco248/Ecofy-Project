from datetime import datetime
from pydantic import BaseModel


class LocationSchema(BaseModel):
    markerId: str
    latitude: float
    longitude: float
    isFull: bool
    hue: float
