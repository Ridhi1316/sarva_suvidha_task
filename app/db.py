from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from app.config import DATABASE_URL

engine = create_engine(DATABASE_URL)  # connect sqlalchemy to postgresql
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)  # app interacts from here
Base = declarative_base()  # define models/tables


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

