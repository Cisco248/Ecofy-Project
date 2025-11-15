from datetime import datetime
from pydantic import BaseModel


class AnnouncementSchema(BaseModel):
    title: str
    description: str
    due_date: datetime
