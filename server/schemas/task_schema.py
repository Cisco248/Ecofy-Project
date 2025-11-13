from datetime import datetime
from pydantic import BaseModel


class TaskSchema(BaseModel):
    title: str
    description: str
    priority: str
    status: str
    due_date: datetime
