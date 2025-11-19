# Project 11: Expense Tracker App

**Created by:** Agent 2 (FinTech Specialist)
**Category:** Finance & Budgeting
**Difficulty:** Intermediate
**Estimated Time:** 10-15 hours

---

## 🎯 Project Overview

A comprehensive personal finance app for tracking expenses, managing budgets, and visualizing spending patterns with beautiful charts and insights.

### Key Features

**Core Functionality:**
- ✅ Add/edit/delete expenses
- ✅ Categorize transactions (Food, Transport, Entertainment, etc.)
- ✅ Set monthly budgets per category
- ✅ Track income sources
- ✅ Search and filter expenses
- ✅ Export data to CSV

**Data Visualization:**
- 📊 Pie charts for category distribution
- 📈 Line graphs for spending trends
- 📉 Budget vs actual spending
- 📱 Weekly/monthly summaries

**Advanced Features:**
- 🔔 Budget limit notifications
- 🏷️ Custom categories
- 💱 Multi-currency support
- 🔐 PIN/biometric lock
- ☁️ Cloud backup (Firebase)
- 🌙 Dark mode

---

## 🏗️ Architecture

This project uses **Clean Architecture** with **BLoC** state management:

```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── usecases/
│   └── utils/
├── features/
│   ├── expenses/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── budgets/
│   ├── categories/
│   ├── analytics/
│   └── settings/
└── main.dart
```

---

## 📦 Dependencies

```yaml
dependencies:
  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Local Storage
  sqflite: ^2.3.0
  path_provider: ^2.1.1

  # Cloud & Auth
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6

  # Charts & Visualization
  fl_chart: ^0.66.0
  syncfusion_flutter_charts: ^24.1.41

  # UI Components
  intl: ^0.19.0
  currency_picker: ^2.0.20
  flutter_slidable: ^3.0.1

  # Utils
  get_it: ^7.6.4
  dartz: ^0.10.1
  csv: ^6.0.0
```

---

## 🗄️ Database Schema

### Expenses Table
```sql
CREATE TABLE expenses (
  id TEXT PRIMARY KEY,
  amount REAL NOT NULL,
  category_id TEXT NOT NULL,
  description TEXT,
  date TEXT NOT NULL,
  payment_method TEXT,
  is_recurring INTEGER DEFAULT 0,
  created_at TEXT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

### Categories Table
```sql
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  icon_code INTEGER NOT NULL,
  color INTEGER NOT NULL,
  budget_limit REAL,
  is_default INTEGER DEFAULT 0
);
```

### Budgets Table
```sql
CREATE TABLE budgets (
  id TEXT PRIMARY KEY,
  category_id TEXT NOT NULL,
  amount REAL NOT NULL,
  period TEXT NOT NULL, -- 'monthly', 'weekly'
  start_date TEXT NOT NULL,
  end_date TEXT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

---

## 🎨 UI Mockups

### Home Screen
```
┌─────────────────────┐
│ October 2024    ⚙️  │
├─────────────────────┤
│ Total Spent         │
│  $1,234.56         │
│                     │
│ Budget: $2,000.00   │
│ [████████░░] 61%    │
├─────────────────────┤
│ Recent Transactions │
│                     │
│ 🍔 Lunch       $15  │
│ 🚕 Uber        $23  │
│ 🎬 Movie       $30  │
│                     │
│ [+ Add Expense]     │
└─────────────────────┘
```

### Analytics Screen
```
┌─────────────────────┐
│ Analytics      📊   │
├─────────────────────┤
│  Category Breakdown │
│                     │
│     [Pie Chart]     │
│                     │
│ 🍔 Food      40%    │
│ 🚗 Transport 30%    │
│ 🎮 Fun       20%    │
│ 💡 Other     10%    │
├─────────────────────┤
│  Spending Trend     │
│     [Line Graph]    │
└─────────────────────┘
```

---

## 📚 Learning Objectives

By building this project, you'll learn:

1. **Local Database Management**
   - SQLite with sqflite
   - CRUD operations
   - Complex queries and joins
   - Database migrations

2. **Data Visualization**
   - Creating charts with fl_chart
   - Interactive graphs
   - Real-time data updates

3. **State Management**
   - BLoC pattern implementation
   - Managing complex state
   - Event-driven architecture

4. **Financial Calculations**
   - Currency formatting
   - Budget calculations
   - Percentage computations
   - Date-based aggregations

5. **Firebase Integration**
   - Cloud Firestore sync
   - Authentication
   - Real-time listeners

---

## 🚀 Getting Started

### 1. Setup
```bash
cd projects/11-expense-tracker
flutter pub get
```

### 2. Run Database Migrations
```bash
flutter run
# Database auto-initializes on first run
```

### 3. Configure Firebase (Optional)
- Add `google-services.json` (Android)
- Add `GoogleService-Info.plist` (iOS)

---

## 🎯 Implementation Roadmap

### Phase 1: Core Features (Week 1-2)
- [ ] Database setup
- [ ] Add/edit/delete expenses
- [ ] Category management
- [ ] Basic list view

### Phase 2: Budgets (Week 3)
- [ ] Create budgets
- [ ] Track spending vs budget
- [ ] Budget notifications
- [ ] Budget history

### Phase 3: Analytics (Week 4)
- [ ] Pie chart for categories
- [ ] Line graph for trends
- [ ] Summary cards
- [ ] Export to CSV

### Phase 4: Advanced (Week 5-6)
- [ ] Firebase sync
- [ ] Multi-currency
- [ ] Recurring expenses
- [ ] Search & filters
- [ ] Dark mode
- [ ] Biometric lock

---

## 🧪 Testing

```bash
# Unit tests
flutter test test/unit/

# Widget tests
flutter test test/widget/

# Integration tests
flutter test integration_test/
```

**Coverage Target:** >80%

---

## 📖 Related Tutorials

- Tutorial 025: SQLite Basics
- Tutorial 026: BLoC State Management
- Tutorial 045: Data Visualization with Charts
- Tutorial 050: Firebase Cloud Sync

---

## 🤝 Contributing

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.

---

## 📄 License

MIT License - See [LICENSE](../../LICENSE)

---

**Status:** 🚧 In Development (Agent 2)
**Last Updated:** 2025-11-19
