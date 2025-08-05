from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from app.db import SessionLocal, engine, Base
from app.routers import wheel, bogie
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title='KPA form API')

app.include_router(wheel.router, prefix='/api/forms', tags=['Wheel Specs'])
app.include_router(bogie.router, prefix='/api/forms', tags=['Bogie Checksheet'])

Base.metadata.create_all(bind=engine)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace with frontend URL later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/ping")
def ping():
    return {"message": "pong"}

