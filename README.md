# 🦋⚙️ Company Scan

**Company Scan** is a **full-stack application** designed to scan, track, and manage company or stock-related data through a modern web interface and a robust backend automation system.

The project is split into two independent but connected applications:

- 🦋 **Frontend** → Built with **Flutter**
- ⚙️ **Backend** → Built with **Django**

<div align="center">
  <p float="left">
    <img src="frontend/lib/images/screenshot_1.png" width="80%" />
  </p>
</div>

## Getting Started

### 1️⃣ Clone the repository

```bash
git clone https://github.com/AppRonin/company-scan.git
cd company-scan
```

### 2️⃣ Frontend Setup

```bash
cd company-scan-front
flutter pub get
flutter run
```

### 3️⃣ Backend Setup

```bash
cd company-scan-back
python manage.py runserver
```

Start Redis:

```bash
sudo service redis-server start
```

Start Dramatiq worker:

```bash
dramatiq tasks.workers
```

## Author

Developed by **AppRonin**, Full-Stack Developer.
