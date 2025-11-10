from sqlalchemy import Column, String, DateTime
from models.base import BASE


class AnnouncementModel(BASE):
    __tablename__ = "announcements"

    id = Column(String, primary_key=True, index=True)
    title = Column(String(20), nullable=False)
    description = Column(String(200), nullable=False)
    due_date = Column(DateTime(), nullable=False)
    created_at = Column(DateTime(timezone=True), nullable=False)
