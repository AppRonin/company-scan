# 📦 Company Scan — Frontend

Company Scan is a **Flutter** application built to provide a smooth interface for scanning, tracking, and managing stock or company-related data.  
It consumes a **REST API** backend to display real-time information and progress updates.

## 📱 Screenshots

<div align="center">
  <p float="left">
    <img src="lib/images/screenshot_1.png" width="80%" />
  </p>
</div>

## 🚀 Features

- 📊 Real-time progress indicators for background tasks
- 🔍 Search and filter stock items
- 🧩 Modular widget-based architecture
- 🌐 Integration with custom REST API (Django/DRF, Node, etc.)
- 🖋️ Custom typography using [Google Fonts](https://pub.dev/packages/google_fonts)
- ⚙️ Smooth animations with `percent_indicator`

---

## 🧰 Tech Stack

| Layer       | Technology                     |
| ----------- | ------------------------------ |
| Framework   | Flutter                        |
| Language    | Dart                           |
| HTTP Client | `http` package                 |
| UI          | Material Design + Google Fonts |
| State       | Stateful Widgets               |
| Indicators  | `percent_indicator` package    |

---

## 🧑‍💻 Project Structure

```
lib/
│
├── widgets/
│   ├── stock_tile.dart        # Reusable stock item widget
│
├── pages/
│   ├── home_page.dart         # Main dashboard page
│
│
└── main.dart                  # Entry point
```

---

## ⚙️ Setup & Installation

### 1. Clone the repository

```bash
git clone https://github.com/AppRonin/company-scan.git
cd company-scan
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

---

## 🧑‍🏭 Author

**AppRonin**

---
