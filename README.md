# 🚆 KPA Form

This project is a full-stack solution for the KPA Assignment, providing a web-based platform to submit, filter, and retrieve data for the "ICF Wheel Specification" form.
The Frontend is built using **Flutter** and runs on the web (Chrome).
The Backend is built with **FastAPI** and uses **PostgreSQL** as the database.

---

## 📦 Tech Stack

- **Flutter** – Cross-platform UI toolkit
- **Python 3.13**
- **FastAPI** – High-performance web framework
- **SQLAlchemy** – ORM for database operations
- **PostgreSQL** – Relational database
- **Pydantic** – Data validation and serialization
- **Uvicorn** – ASGI web server
- **python-dotenv** – Manage environment variables


---

## ⚙️ Setup Instructions

### 🔹 1. Clone the Repository

```bash
git clone https://github.com/Ridhi1316/sarva_suvidha_task.git
cd sarva_assignment_task
```

### 🔹 2. Create a Virtual Environment

```bash
python -m venv venv
source venv/bin/activate
```

### 🔹 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 🔹 4. Setup PostgreSQL

1. Ensure PostgreSQL is installed and running.
2. Create a database:

```bash
sudo -u postgres psql
CREATE DATABASE kpa_db;
ALTER USER postgres WITH PASSWORD 'yourpassword';
\q
```

### 🔹 5. Configure Environment Variables

Create a `.env` file in the root directory:

```env
DATABASE_URL=postgresql://postgres:yourpassword@localhost/kpa_db
```

> Replace `yourpassword` with your actual PostgreSQL password.


### 🔹 6. Run the API Server

```bash
uvicorn app.main:app --reload
```

Open Swagger Docs at: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

---

## 📌 Implemented API Endpoints

### ✅ POST `/api/forms/wheel-specifications`

- Accepts a JSON payload of wheel measurements.
- Saves the data to the database.
- Returns form metadata and a success message.

### ✅ GET `/api/forms/wheel-specifications`

- Supports filtering via:
  - `formNumber`
  - `submittedBy`
  - `submittedDate`
- Returns a list of matching form records in the specified structure.

---

## 🔍 API Testing

You can test the API using:

- ✅ **Swagger UI** at [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
- ✅ **Postman** using the provided Postman collection (`KPA_form data.postman_collection.json`)

---

## 🗂 Directory Structure

```
sarva_Suvidha_project/
├── app/
│   ├── main.py
│   ├── models/
│   ├── routers/
│   ├── schemas/
│   ├── db.py
|   └── config.py
├── .env
├── requirements.txt
├── README.md
├── KPA_form data.postman_collection.json
└── KPA-ERP-FE-dev_afoz

```

---

## ⚠️ Assumptions & Limitations

- No user authentication or file uploads implemented.
- Date filtering is done via string in `YYYY-MM-DD` format.
- Responses are strictly based on assignment-provided schemas.
- PostgreSQL is assumed to be locally hosted on default port `5432`.

---

## 🧪 Sample Query Example

```http
POST /api/forms/wheel-specifications
```

Response:
```json
{
    "success": true,
    "message": "Wheel specification submitted successfully.",
    "data": {
        "formNumber": "WHEEL-2025-100",
        "submittedBy": "user_id_129",
        "submittedDate": "2025-08-05",
        "status": "Saved"
    }
}
```

---


## 📜 License

This project is for assignment purposes only.
