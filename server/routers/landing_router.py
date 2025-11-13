import uuid
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import datetime
from database.init import get_db
from models.news_model import NewsModel
from models.task_model import TaskModel
from models.announcement_model import AnnouncementModel
from schemas.announcement_schema import AnnouncementSchema
from schemas.news_schema import NewsSchema
from schemas.task_schema import TaskSchema

router = APIRouter()


@router.post("/task-data", status_code=200)
def post_task(task: TaskSchema, db: Session = Depends(get_db)):
    exist_task = db.query(TaskModel).filter(TaskModel.title == task.title).first()
    if exist_task:
        raise HTTPException(status_code=400, detail="Task already added!")

    new_task_db = TaskModel(
        id=str(uuid.uuid4()),
        title=task.title,
        description=task.description,
        priority=task.priority,
        status=task.status,
        due_date=task.due_date,
        created_at=datetime.datetime.now(),
    )

    db.add(new_task_db)
    db.commit()
    db.refresh(new_task_db)

    return new_task_db


@router.get("/task-data", status_code=200, response_model=list[TaskSchema])
def task_api_router(db: Session = Depends(get_db), limit: int = 5):
    task_query = db.query(NewsModel).limit(limit).all()
    if not task_query:
        raise HTTPException(status_code=400, detail="Task doesn't added!")
    return task_query


@router.post("/news-data", status_code=200)
def post_news(news: NewsSchema, db: Session = Depends(get_db)):
    exist_news = db.query(NewsModel).filter(NewsModel.title == news.title).first()
    if not exist_news:
        raise HTTPException(status_code=404, detail="News already added!")

    news_news_db = NewsModel(
        id=str(uuid.uuid4()),
        title=news.title,
        description=news.description,
        due_date=news.due_date,
        created_at=datetime.datetime.now(),
    )

    db.add(news_news_db)
    db.commit()
    db.refresh(news_news_db)

    return news_news_db


@router.get("/news-data", status_code=200, response_model=list[NewsSchema])
def news_api_router(db: Session = Depends(get_db), limit: int = 5):
    news_query = db.query(NewsModel).limit(limit).all()
    if not news_query:
        raise HTTPException(status_code=400, detail="News doesn't exosts!")
    return news_query


@router.post("/announce-data", status_code=200)
def post_announce(announce: AnnouncementSchema, db: Session = Depends(get_db)):
    exist_announce = (
        db.query(AnnouncementModel)
        .filter(AnnouncementModel.title == announce.title)
        .first()
    )
    if not exist_announce:
        raise HTTPException(status_code=404, detail="Announcement already added!")

    news_announce_db = NewsModel(
        id=str(uuid.uuid4()),
        title=announce.title,
        description=announce.description,
        due_date=announce.due_date,
        created_at=datetime.datetime.now(),
    )

    db.add(news_announce_db)
    db.commit()
    db.refresh(news_announce_db)

    return news_announce_db


@router.get("/announce-data", status_code=200, response_model=list[AnnouncementSchema])
def announcement_api_router(db: Session = Depends(get_db), limit: int = 5):
    anounce_query = db.query(AnnouncementModel).limit(limit).all()
    if not anounce_query:
        raise HTTPException(status_code=400, detail="Announcement doesn't exists!")
    return anounce_query
