from pydantic import BaseModel


class TaskSchema(BaseModel):
    id: str
    title: str
    description: str
    priority: str
    status: str
    due_date: str
    created_at: str
