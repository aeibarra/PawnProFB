# PawnPro - Pawn Shop Management System

A complete pawn shop management web application built with Python Flask and Firebird 5 database.

## Features

- **Dashboard**: Overview statistics including active loans, revenue, overdue transactions
- **Customer Management**: Add, edit, view, delete customers with ID tracking
- **Item/Inventory Management**: Track items with categories, condition, status, appraised value
- **Pawn Transactions**: Create loans, track collateral, process redemptions and forfeitures
- **Sales Management**: Record item sales with optional customer association
- **Item Categories**: Pre-seeded categories (Electronics, Jewelry, Tools, etc.)

## Prerequisites

- Python 3.10+
- Firebird 5.0 Server installed and running
- pip

## Setup

### 1. Install Firebird 5

Install Firebird 5.0 server from https://firebirdsql.org/

### 2. Create the Database

Using isql (Firebird command line):
```bash
isql -user SYSDBA -password masterkey
SQL> CREATE DATABASE '/var/lib/firebird/5.0/data/pawnpro.fdb' PAGE_SIZE 8192 DEFAULT CHARACTER SET UTF8;
SQL> EXIT;
isql -user SYSDBA -password masterkey /var/lib/firebird/5.0/data/pawnpro.fdb
SQL> INPUT 'database/schema.sql';
SQL> EXIT;
```

### 3. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure Environment (Optional)

Create a `.env` file or set environment variables:
```
SECRET_KEY=your-secret-key
FIREBIRD_HOST=localhost
FIREBIRD_PORT=3050
FIREBIRD_DATABASE=/var/lib/firebird/5.0/data/pawnpro.fdb
FIREBIRD_USER=SYSDBA
FIREBIRD_PASSWORD=masterkey
```

### 5. Run the Application

```bash
python run.py
```

Open your browser at http://localhost:5000

## Project Structure

```
PawnProFB/
├── app/
│   ├── __init__.py          # App factory
│   ├── database.py          # DB connection
│   ├── models/              # Data models
│   ├── routes/              # Flask blueprints
│   └── templates/           # Jinja2 HTML templates
├── database/
│   └── schema.sql           # Firebird DDL
├── config.py
├── run.py
└── requirements.txt
```

## Tech Stack

- **Backend**: Python Flask 3.x
- **Database**: Firebird 5.0 via `firebird-driver`
- **Frontend**: Bootstrap 5.3, Bootstrap Icons

---

<!-- original README below -->