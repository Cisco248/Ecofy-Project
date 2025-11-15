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
    """
    Create a new task and store it in the database.
    This endpoint accepts task data, validates that a task with the same title doesn't
    already exist, creates a new task record with a unique UUID, and persists it to
    the database.

    Args:
        task (TaskSchema):
            - The task data transfer object containing title, description, priority, status, and due_date.
        db (Session):
            - SQLAlchemy database session dependency for database operations.

    Returns:
        TaskModel:
            - The created task object with all fields populated, including the generated UUID and creation timestamp.

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
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


@router.get("/task-data", status_code=200)
def task_api_router(db: Session = Depends(get_db), limit: int = 3):
    """
    Retrieve all tasks from the database.

    This endpoint fetches all task records from the database and returns them as a list of TaskSchema objects.

    Args:
        db (Session): Database session dependency for querying tasks.

    Returns:
        list[TaskSchema]: A list of all tasks in the database.

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
    task_query = db.query(TaskModel).limit(limit).all()
    if not task_query:
        raise HTTPException(status_code=400, detail="Task doesn't added!")
    return task_query


@router.post("/news-data", status_code=200)
def post_news(news: NewsSchema, db: Session = Depends(get_db)):
    """
    Post a new news item to the database.

    Args:
        news(NewsSchema):
            - The news data to be added, containing `title, description, and due_date`.
        db(Session):
            - Database session dependency for executing queries and transactions.

    Returns:
        NewsModel:
            - The newly created news object with generated id and created_at timestamp.

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
    exist_news = db.query(NewsModel).filter(NewsModel.title == news.title).first()
    if exist_news:
        raise HTTPException(status_code=400, detail="News already added!")

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


@router.get("/news-data", status_code=200)
def news_api_router(db: Session = Depends(get_db), limit: int = 3):
    """
    Retrieve a list of news articles from the database.

    This endpoint fetches news articles with a configurable limit on the number of results returned. It queries the NewsModel table and returns the results as a list of NewsSchema objects.

    Args:
        db (Session):
            - Database session dependency for querying the database.
        limit (int):
            - Maximum number of news articles to retrieve. Defaults to 5.

    Returns:
        list[NewsSchema]:
            - A list of news articles matching the query.

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
    news_query = db.query(NewsModel).limit(limit).all()
    if not news_query:
        raise HTTPException(status_code=400, detail="News doesn't exosts!")
    return news_query


@router.post("/announce-data", status_code=200)
def post_announce(announce: AnnouncementSchema, db: Session = Depends(get_db)):
    """
    Create a new announcement in the database. This endpoint handles POST requests to create and store a new announcement. It first checks if an announcement with the same title already exists to prevent duplicates. If the announcement is new, it creates a record with a generated UUID, persists it to the database, and returns the created announcement object.

    Args:
        announce(AnnouncementSchema):
            - The announcement data transfer object containing `title, description, and due_date`.
        db (Session):
            - The database session dependency for performing database operations.

    Returns:
        ```python
            AnnouncementModel {
                id: str
                title: str
                description: str
                due_date: str
                created_at: datetime
            }
        ```

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
    exist_announce = (
        db.query(AnnouncementModel)
        .filter(AnnouncementModel.title == announce.title)
        .first()
    )
    if exist_announce:
        raise HTTPException(status_code=400, detail="Announcement already added!")

    news_announce_db = AnnouncementModel(
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


@router.get("/announce-data", status_code=200)
def announcement_api_router(db: Session = Depends(get_db), limit: int = 5):
    """
    Retrieve a list of announcements with pagination support.

    This endpoint fetches announcements from the database with a configurable limit to control the number of results returned.

    Args:
        db(Session):
            - Database session dependency for querying the database.
        limit(int, optional):
            - Maximum number of announcements to retrieve. Defaults to 5.

    Returns:
        list[AnnouncementSchema]:
            - A list of announcement objects matching the query criteria.

    Raises:
        HTTPException:
            - If no news articles are found in the database. Raise the `status_code` of request, `Detail` of error.
    """
    anounce_query = db.query(AnnouncementModel).limit(limit).all()
    if not anounce_query:
        raise HTTPException(status_code=400, detail="Announcement doesn't exists!")
    return anounce_query
