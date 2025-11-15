from sqlalchemy import Column, String, DateTime
from models.base import BASE


class AnnouncementModel(BASE):
    __tablename__ = "announcements"

    id = Column(String, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    due_date = Column(DateTime)
    created_at = Column(DateTime)
