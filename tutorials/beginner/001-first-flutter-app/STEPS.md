# Steps: Build Your First Flutter App

**Tutorial 001** | **Estimated Time:** 15 minutes

---

## 🎯 What You'll Build

A simple Flutter app that displays "Hello, Flutter!" on the screen with a Material Design app bar.

**Final Result:**
```
┌─────────────────────┐
│ My First App        │  ← App Bar
├─────────────────────┤
│                     │
│                     │
│  Hello, Flutter!    │  ← Centered Text
│                     │
│                     │
└─────────────────────┘
```

---

## Step 1: Set Up Your Development Environment

### Prerequisites Check

Before starting, ensure you have:
- ✅ Flutter SDK installed
- ✅ An IDE (VS Code or Android Studio)
- ✅ iOS Simulator or Android Emulator running

### Verify Installation

```bash
flutter doctor
```

You should see ✓ marks for Flutter, your IDE, and at least one connected device.

---

## Step 2: Create a New Flutter Project

### Using Command Line

```bash
# Navigate to your projects directory
cd ~/Documents/flutter-projects

# Create a new Flutter project
flutter create my_first_app

# Navigate into the project
cd my_first_app
```

### Using VS Code

1. Press **Cmd+Shift+P** (Mac) or **Ctrl+Shift+P** (Windows/Linux)
2. Type **"Flutter: New Project"**
3. Select **"Application"**
4. Choose a location
5. Name it **"my_first_app"**

### Using Android Studio

1. **File** → **New** → **New Flutter Project**
2. Select **"Flutter Application"**
3. Name it **"my_first_app"**
4. Click **"Finish"**

---

## Step 3: Understand the Project Structure

Your project should have this structure:

```
my_first_app/
├── lib/
│   └── main.dart          ← Your app code goes here
├── test/
│   └── widget_test.dart   ← Tests
├── android/               ← Android-specific files
├── ios/                   ← iOS-specific files
├── pubspec.yaml          ← Dependencies configuration
└── README.md
```

**Key file:** `lib/main.dart` - This is where you'll write your app!

---

## Step 4: Open main.dart

Navigate to `lib/main.dart` and you'll see template code. We'll replace it completely.

**Delete all the existing code** in `main.dart`.

---

## Step 5: Import Flutter Material Library

Start with the import statement:

```dart
import 'package:flutter/material.dart';
```

**Why?**
- Provides access to Material Design widgets
- Required for MaterialApp, Scaffold, Text, etc.

---

## Step 6: Create the main() Function

Add the main function:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
```

**What this does:**
- `main()` - Entry point of your app
- `runApp()` - Starts the Flutter engine and displays your app
- `MyApp()` - Your root widget (we'll create this next)

---

## Step 7: Create the MyApp Widget

Add the MyApp class below main():

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

**Let's break this down:**

### MyApp extends StatelessWidget
- Creates a widget that doesn't change
- Perfect for our simple app

### build() Method
- Returns the widget tree
- Called when Flutter needs to display your widget

### MaterialApp
- Root widget for Material Design apps
- `title`: App name (shows in task switcher)
- `home`: The main screen

### Scaffold
- Provides basic visual structure
- `appBar`: Top bar
- `body`: Main content

### AppBar
- Material Design app bar
- Contains the title

### Center
- Centers its child widget

### Text
- Displays "Hello, Flutter!"

---

## Step 8: Save and Run the App

### Save the File

**VS Code:** Ctrl+S (Windows/Linux) or Cmd+S (Mac)

**Android Studio:** Ctrl+S or Cmd+S

### Run the App

**Option 1: Command Line**
```bash
flutter run
```

**Option 2: VS Code**
- Press **F5** or click **"Run" → "Start Debugging"**

**Option 3: Android Studio**
- Click the green **▶ Run** button

### Wait for Build

First build takes 1-3 minutes. Subsequent builds are much faster!

---

## Step 9: See Your App Running

You should see:
- A blue app bar at the top
- "My First App" as the title
- "Hello, Flutter!" centered in the middle

**Congratulations! You've created your first Flutter app!** 🎉

---

## Step 10: Try Hot Reload

Let's make a change and see hot reload in action!

### Change the Text

Modify the Text widget:

```dart
Text('Hello, Flutter!'),  // Before
Text('Hello, World!'),    // After
```

### Save the File

Press **Ctrl+S** / **Cmd+S**

### See Instant Update

The text should update immediately without restarting the app!

**This is hot reload in action!**

---

## Step 11: Customize Your App

Try these modifications:

### Change the App Bar Color

```dart
appBar: AppBar(
  title: Text('My First App'),
  backgroundColor: Colors.purple,  // Add this line
),
```

### Change the Text Style

```dart
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
),
```

### Add More Widgets

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Hello, Flutter!',
        style: TextStyle(fontSize: 32),
      ),
      SizedBox(height: 20),
      Text(
        'My first app',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ],
  ),
),
```

Save and see the changes with hot reload!

---

## Step 12: Complete Code

Here's the complete `main.dart`:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

**Total lines:** ~20 lines of code!

---

## ✅ Checkpoint: Verify Your App

Make sure:
- [ ] App runs without errors
- [ ] You see a blue app bar
- [ ] Text is centered
- [ ] Hot reload works when you save

---

## 🐛 Troubleshooting

### "No devices found"
**Solution:** Start your emulator/simulator

### "Error: Cannot run with sound null safety"
**Solution:** Flutter version issue. Update Flutter:
```bash
flutter upgrade
```

### Red screen with error
**Solution:** Check for typos in your code. Common issues:
- Missing semicolons (`;`)
- Mismatched parentheses
- Incorrect capitalization

### App doesn't update after saving
**Solution:**
1. Try hot restart: Press `R` in terminal
2. Stop and restart the app
3. Check for errors in console

---

## 🎯 What You Accomplished

You just:
- ✅ Created your first Flutter project
- ✅ Wrote a complete Flutter app
- ✅ Used Material Design widgets
- ✅ Experienced hot reload
- ✅ Customized your app

---

## 🚀 Next Steps

1. **Code Explanation:** Read [CODE_EXPLANATION.md](CODE_EXPLANATION.md) for a deep dive
2. **Practice:** Try the challenges in [CHALLENGES.md](CHALLENGES.md)
3. **Experiment:** Modify the app and explore different widgets

---

**Great job!** You're now a Flutter developer! 🎉
