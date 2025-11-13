from pydantic import BaseModel


class NewsSchema(BaseModel):
    title: str
    description: str
    due_date: str
