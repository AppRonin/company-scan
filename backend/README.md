# ⚙️ Company Scan Backend

Backend service for **Company Scan**, built with **Django**, **DRF**, **Dramatiq**, and **Redis**.  
It powers the web automation system used by the Flutter frontend.

## Getting Started

### 1️⃣ Clone the repo

```bash
git clone https://github.com/AppRonin/company-scan.git
cd company-scan
```

### 2️⃣ Run the API server

```bash
cd backend
python manage.py runserver
```

### 3️ Run Redis

```bash
sudo service redis-server start
```

### 4️⃣ Start Dramatiq worker

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
