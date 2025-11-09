from pydantic import BaseModel


class AnnouncementSchema(BaseModel):
    id: str
    title: str
    description: str
    due_date: str
    created_at: str
