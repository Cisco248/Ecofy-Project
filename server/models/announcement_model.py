import datetime
from sqlalchemy import Column, String, DateTime
from models.base import BASE


class AnnouncementModel(BASE):
    __tablename__ = "announcements"

    id = Column(String, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(String)
    due_date = Column(DateTime)
    created_at = Column(DateTime, default=datetime.datetime)
