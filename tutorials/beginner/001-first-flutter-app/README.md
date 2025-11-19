# Tutorial 001: Your First Flutter App

**Created by:** Agent 7 (Tutorial Content Creator)
**Difficulty:** Beginner
**Estimated Time:** 30 minutes
**Prerequisites:** None - perfect for absolute beginners!

## 🎯 What You'll Build

A simple "Hello World" Flutter app that displays text and responds to button clicks. Perfect for understanding Flutter basics!

<img src="assets/screenshot.png" width="300" alt="First Flutter App Screenshot">

## ⏱ Time Breakdown

- Setup: 5 min
- Implementation: 15 min
- Testing: 5 min
- Challenges: 5 min

## 📚 Prerequisites

**Knowledge:**
- [ ] Basic programming concepts (variables, functions)
- [ ] Familiarity with mobile apps

**Tools Needed:**
- Flutter SDK 3.0+
- VS Code or Android Studio
- iOS Simulator / Android Emulator

## 🎓 Learning Objectives

By the end of this tutorial, you will be able to:

1. **Create** a new Flutter project
2. **Understand** the basic Flutter project structure
3. **Write** your first Flutter widget
4. **Run** the app on a simulator/emulator
5. **Make** simple UI changes

## 🚀 Getting Started

### Step 1: Navigate to Starter Code

```bash
cd tutorials/beginner/001-first-flutter-app/starter
flutter pub get
flutter run
```

### Step 2: Explore the Files

The starter code has:
- ✅ Basic project structure
- ⬜ Empty `main.dart` (you'll fill this in!)
- ✅ Configuration files

## 📖 Tutorial Path

Follow these guides in order:

1. **[CONCEPTS.md](CONCEPTS.md)** - Understanding widgets (10 min)
2. **[STEPS.md](STEPS.md)** - Build step-by-step (15 min)
3. **[CODE_EXPLANATION.md](CODE_EXPLANATION.md)** - Deep dive (10 min)
4. **[CHALLENGES.md](CHALLENGES.md)** - Practice (15 min)

## 🎯 What You'll Learn

### Key Concepts

- **Widgets**: Everything in Flutter is a widget
- **MaterialApp**: The root of your app
- **Scaffold**: Basic screen structure
- **StatelessWidget vs StatefulWidget**
- **Hot Reload**: Flutter's superpower

### Flutter Basics

```dart
// This is what you'll build!
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My First App')),
        body: Center(child: Text('Hello, Flutter!')),
      ),
    );
  }
}
```

## ✅ Completion Checklist

Before moving to the next tutorial:

- [ ] App runs without errors
- [ ] You can explain what each line does
- [ ] You've completed at least 1 challenge
- [ ] You understand hot reload
- [ ] You can create a widget from scratch

## 📊 Self-Assessment

Rate your understanding (1-5):

- [ ] I understand what a widget is: ___/5
- [ ] I can create a StatelessWidget: ___/5
- [ ] I know how to use hot reload: ___/5
- [ ] I'm ready for Tutorial 002: ___/5

## 🔗 Related Content

**Next Tutorials:**
- Tutorial 002: Understanding Widgets
- Tutorial 003: StatelessWidget vs StatefulWidget

**Related Projects:**
- Project 01: Counter & Todo App

## 🆘 Getting Help

**Stuck?**
1. Check [COMMON_MISTAKES.md](COMMON_MISTAKES.md)
2. Review [CONCEPTS.md](CONCEPTS.md)
3. Compare with `solution/` code
4. Search [Flutter Docs](https://flutter.dev/docs)

**Found a bug?**
Report in the main repository

---

**Ready to build your first app? Let's go!** 🚀
