# Concepts: Your First Flutter App

**Tutorial 001** | **Estimated Time:** 10 minutes

---

## 🎯 What You'll Learn

This guide explains the fundamental concepts you need to understand before building your first Flutter app.

---

## 1. What is Flutter?

### Definition
Flutter is an **open-source UI toolkit** created by Google for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

### Key Features
- **Fast Development**: Hot reload helps you experiment and build UIs quickly
- **Expressive UI**: Build beautiful apps with rich widgets
- **Native Performance**: Compiled to native ARM code for best performance

---

## 2. Everything is a Widget

### What is a Widget?

In Flutter, **everything you see on the screen is a widget**. Widgets are the building blocks of Flutter apps.

```dart
// Examples of widgets:
Text('Hello')        // Displays text
Container()          // A box for layout
Image.network()      // Displays an image
Button()             // An interactive button
```

### Widget Tree

Widgets are organized in a tree structure. Each widget can contain other widgets (children).

```
MaterialApp
 └─ Scaffold
     ├─ AppBar
     │   └─ Text('Title')
     └─ Body
         └─ Center
             └─ Text('Hello, Flutter!')
```

---

## 3. StatelessWidget vs StatefulWidget

### StatelessWidget

A widget that **doesn't change** over time. Once built, it stays the same.

**When to use:**
- Displaying static content
- Text labels
- Icons
- Images that don't change

**Example:**
```dart
class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Welcome!'); // This text never changes
  }
}
```

### StatefulWidget

A widget that **can change** over time. It maintains state that can be updated.

**When to use:**
- Interactive elements
- Forms with user input
- Counters
- Anything that updates based on user action

**Example:**
```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0; // This can change!

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}
```

---

## 4. Essential Widgets

### MaterialApp

The **root** of your Flutter app. It provides Material Design styling.

```dart
MaterialApp(
  title: 'My App',
  theme: ThemeData(primarySwatch: Colors.blue),
  home: MyHomePage(),
)
```

**Purpose:**
- Sets up navigation
- Defines app theme
- Provides Material Design components

### Scaffold

Provides a **basic visual layout** structure for Material Design apps.

```dart
Scaffold(
  appBar: AppBar(title: Text('Home')),
  body: Center(child: Text('Content here')),
  floatingActionButton: FloatingActionButton(),
)
```

**Components:**
- `appBar`: Top bar with title
- `body`: Main content area
- `floatingActionButton`: Floating action button
- `drawer`: Side menu
- `bottomNavigationBar`: Bottom navigation

### Container

A versatile widget for **layout and decoration**.

```dart
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
  padding: EdgeInsets.all(8),
  margin: EdgeInsets.all(16),
  child: Text('Inside container'),
)
```

**Use cases:**
- Adding padding/margin
- Setting background colors
- Sizing widgets
- Decorating with borders/shadows

### Center

Centers its child widget.

```dart
Center(
  child: Text('I am centered!'),
)
```

### Text

Displays text on screen.

```dart
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

---

## 5. The build() Method

### What It Does

The `build()` method tells Flutter **how to display your widget**.

```dart
@override
Widget build(BuildContext context) {
  return Text('This is what you see');
}
```

### When It's Called

Flutter calls `build()`:
- When the widget is first created
- When the parent widget changes
- When `setState()` is called (for StatefulWidget)

### BuildContext

The `context` parameter provides information about the widget's location in the widget tree.

**Common uses:**
```dart
// Get theme data
Theme.of(context).primaryColor

// Navigate to another screen
Navigator.of(context).push(...)

// Show a snackbar
ScaffoldMessenger.of(context).showSnackBar(...)
```

---

## 6. Hot Reload: Flutter's Superpower

### What is Hot Reload?

Hot reload allows you to **see changes instantly** without restarting your app.

### How to Use

1. Make a code change
2. Press:
   - **`r`** in terminal (for `flutter run`)
   - **Ctrl+S** / **Cmd+S** in VS Code (with Flutter extension)
   - **⚡ icon** in IDE toolbar

3. See changes in ~1 second!

### What Gets Preserved

✅ **Preserved:**
- App state
- Current screen
- User input

❌ **Not preserved:**
- Global variables
- Static fields
- `main()` function changes

### Hot Restart

If hot reload doesn't work, use **hot restart**:
- Press **`R`** in terminal
- Restarts the app but keeps it running

---

## 7. The main() Function

### Entry Point

Every Flutter app starts with `main()`:

```dart
void main() {
  runApp(MyApp());
}
```

### runApp()

The `runApp()` function:
- Takes a widget as argument
- Makes it the root of the widget tree
- Runs the app

---

## 8. Import Statements

### flutter/material.dart

Import this to use Material Design widgets:

```dart
import 'package:flutter/material.dart';
```

**Provides:**
- MaterialApp
- Scaffold
- Text, Button, Icon
- Material Design styling

### Other Common Imports

```dart
import 'package:flutter/cupertino.dart'; // iOS-style widgets
import 'package:flutter/services.dart';  // Platform services
```

---

## 9. Dart Basics You Need

### Class Declaration

```dart
class MyApp extends StatelessWidget {
  // Class body
}
```

### Override Annotation

```dart
@override  // Indicates we're overriding a parent method
Widget build(BuildContext context) {
  // ...
}
```

### Const Keyword

```dart
const Text('Hello'); // Compile-time constant for better performance
```

**When to use `const`:**
- Widget won't change
- Improves performance
- Reduces memory usage

---

## 10. Key Takeaways

### Remember These Points

1. **Everything is a widget** - Text, buttons, layouts, everything!

2. **Widget tree** - Widgets contain other widgets in a tree structure

3. **Stateless vs Stateful**:
   - Stateless: Doesn't change
   - Stateful: Can change over time

4. **MaterialApp** - Root of your app

5. **Scaffold** - Provides basic layout structure

6. **build()** - Returns what you want to display

7. **Hot reload** - See changes instantly

---

## 🤔 Self-Check Questions

Before moving on, make sure you can answer:

1. What is a widget?
2. What's the difference between StatelessWidget and StatefulWidget?
3. What does MaterialApp do?
4. What is the purpose of the build() method?
5. How do you use hot reload?

---

## 📚 Further Reading

- [Flutter Widgets Catalog](https://flutter.dev/docs/development/ui/widgets)
- [Introduction to Widgets](https://flutter.dev/docs/development/ui/widgets-intro)
- [StatelessWidget vs StatefulWidget](https://flutter.dev/docs/development/ui/interactive)

---

**Ready to build?** Continue to [STEPS.md](STEPS.md) to create your first app!
