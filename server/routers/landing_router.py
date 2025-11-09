from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database.init import get_db
from schemas.news_schema import NewsSchema
from schemas.task_schema import TaskSchema
from schemas.announcement_schema import AnnouncementSchema
from models.news_model import NewsModel
from models.task_model import TaskModel
from models.announcement_model import AnnouncementModel


router = APIRouter()


@router.get("/task-data", status_code=201)
def task_api_router(task: TaskSchema, db: Session = Depends(get_db)):
    task_query = db.query(TaskModel).count()
    if not task_query:
        raise HTTPException(status_code=400, detail="Task doesn't added!")
    return task_query


@router.get("/news-data", status_code=201)
def news_api_router(news: NewsSchema, db: Session = Depends(get_db)):
    news_query = db.query(NewsModel).count()
    if not news_query:
        raise HTTPException(status_code=400, detail="News doesn't exosts!")
    return news_query


@router.get("/announcement-data", status_code=201)
def announcement_api_router(
    announce: AnnouncementSchema, db: Session = Depends(get_db)
):
    anounce_query = db.query(AnnouncementModel).count()
    if not anounce_query:
        raise HTTPException(status_code=400, detail="Announcement doesn't exists!")
    return anounce_query
