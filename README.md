# ⚙️ Company Scan Backend

Backend service for **Company Scan**, built with **Django**, **DRF**, **Dramatiq**, and **Redis**.  
It powers the web automation system used by the Flutter frontend.

## Tech Stack

- 🐍 **Django** – Core web framework
- ⚡ **Django REST Framework (DRF)** – RESTful API support
- 🎭 **Dramatiq** – Background task processing
- 🧩 **Redis** – Message broker and caching layer
- 🐘 **PostgreSQL** – Relational database for data persistence

## Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/AppRonin/company-scan.git
cd company-scan/company-scan-back/
```

### 2️⃣ Run Redis

```bash
sudo service redis-server start
```

### 3️⃣ Run the API server

```bash
python manage.py runserver
```

### 4️⃣ Start Dramatiq worker

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
