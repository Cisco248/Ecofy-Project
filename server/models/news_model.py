from sqlalchemy import Column, String, DateTime
from models.base import BASE


class NewsModel(BASE):
    __tablename__ = "news"

    id = Column(String, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    due_date = Column(DateTime)
    created_at = Column(DateTime)
