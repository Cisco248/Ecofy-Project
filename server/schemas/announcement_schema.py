from pydantic import BaseModel


class AnnouncementSchema(BaseModel):
    title: str
    description: str
    due_date: str
