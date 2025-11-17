# Project 1: Counter & Todo App - Roadmap

## 🎯 Project Overview

**Difficulty:** Beginner
**Estimated Time:** 4-6 hours
**Focus Areas:** Flutter basics, StatefulWidget, navigation, local state management

---

## 📚 Learning Objectives

By completing this project, you will learn:

- ✅ Flutter project structure
- ✅ StatelessWidget vs StatefulWidget
- ✅ setState() mechanism and when widgets rebuild
- ✅ Navigation between screens
- ✅ Basic Material Design widgets
- ✅ List handling with ListView
- ✅ Data persistence with shared_preferences
- ✅ CRUD operations (Create, Read, Update, Delete)

---

## ✅ What's Already Implemented

### **1. Basic App Structure**
- ✅ `main.dart` - App entry point
- ✅ `home_screen.dart` - Home screen with navigation
- ✅ `counter_screen.dart` - **Fully implemented counter**
- ✅ Material Design theme setup
- ✅ Navigation routing

### **2. Counter Feature (Complete Example)**
The counter is **fully implemented** as a reference for you to learn from:
- Increment, decrement, reset functionality
- StatefulWidget lifecycle
- setState() usage
- AppBar with actions
- FloatingActionButton
- Text styling and theming

**File:** `lib/screens/counter_screen.dart`

**Study this implementation** - it demonstrates all the patterns you'll use for the Todo app!

---

## 🔨 Your Tasks - What You Need to Build

### **Task 1: Create Todo Model**
**File to create:** `lib/models/todo.dart`

Create a Todo class with:
- `String id` - Unique identifier
- `String title` - Todo title
- `String? description` - Optional description
- `bool isCompleted` - Completion status
- `DateTime createdAt` - Creation timestamp

**Hints:**
- Use `uuid` package for generating unique IDs
- Add `toJson()` and `fromJson()` methods for persistence
- Override `toString()` for debugging

**Example structure:**
```dart
class Todo {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;

  // Constructor
  // toJson() method
  // fromJson() factory
  // copyWith() method for updates
}
```

---

### **Task 2: Build Todo List Screen**
**File to create:** `lib/screens/todo_screen.dart`

Build a screen that displays a list of todos:

**Required Features:**
- [ ] AppBar with title "My Todos"
- [ ] ListView.builder to display todos
- [ ] Empty state when no todos exist
- [ ] FloatingActionButton to add new todo
- [ ] Each todo item shows:
  - [ ] Checkbox for completion status
  - [ ] Title
  - [ ] Delete icon button
- [ ] Tap on todo to view/edit details

**Widgets to use:**
- `Scaffold`
- `AppBar`
- `ListView.builder`
- `ListTile` or custom `Card` widget
- `Checkbox`
- `IconButton`
- `FloatingActionButton`

**State to manage:**
- List of todos
- Loading state
- Empty state

---

### **Task 3: Create Add/Edit Todo Screen**
**File to create:** `lib/screens/add_edit_todo_screen.dart`

Build a form screen for adding and editing todos:

**Required Features:**
- [ ] AppBar with dynamic title ("Add Todo" or "Edit Todo")
- [ ] TextField for title (required)
- [ ] TextField for description (optional, multiline)
- [ ] Save button (validates title is not empty)
- [ ] Cancel button
- [ ] Pass todo data back to previous screen

**Widgets to use:**
- `Scaffold`
- `Form` and `TextFormField`
- `ElevatedButton`
- `TextButton`
- `InputDecoration`

**Validation:**
- Title cannot be empty
- Show error message if validation fails

**Navigation:**
- Push to this screen from TodoScreen
- Pop with result when saved

---

### **Task 4: Implement CRUD Operations**

**In `todo_screen.dart`, implement:**

**Create:**
- [ ] Navigate to AddEditTodoScreen
- [ ] Receive new todo from navigation result
- [ ] Add to list with setState()

**Read:**
- [ ] Display all todos in ListView
- [ ] Show completed vs incomplete differently
- [ ] Count total and completed todos

**Update:**
- [ ] Toggle completion status on checkbox tap
- [ ] Navigate to edit screen on todo tap
- [ ] Update todo in list

**Delete:**
- [ ] Delete todo on icon button press
- [ ] Show confirmation dialog (optional)
- [ ] Remove from list with setState()

---

### **Task 5: Add Data Persistence**
**File to create:** `lib/services/todo_storage.dart`

Use `shared_preferences` to save todos:

**Required Features:**
- [ ] Save todos to shared_preferences when list changes
- [ ] Load todos when app starts
- [ ] Convert todos to/from JSON
- [ ] Handle empty state (no saved data)

**Add to `pubspec.yaml`:**
```yaml
dependencies:
  shared_preferences: ^2.2.2
  uuid: ^4.3.3
```

**Methods to implement:**
```dart
class TodoStorage {
  static const String _key = 'todos';

  Future<void> saveTodos(List<Todo> todos) async {
    // Convert todos to JSON and save
  }

  Future<List<Todo>> loadTodos() async {
    // Load and parse JSON to todos
  }

  Future<void> clearTodos() async {
    // Clear all saved todos
  }
}
```

---

### **Task 6: Enhance UI/UX (Optional Challenges)**

**Basic Enhancements:**
- [ ] Add todo count in AppBar subtitle
- [ ] Different text style for completed todos (strikethrough)
- [ ] Show creation date for each todo
- [ ] Add pull-to-refresh

**Intermediate Enhancements:**
- [ ] Filter todos (All, Active, Completed)
- [ ] Search functionality
- [ ] Sort by date or alphabetically
- [ ] Swipe-to-delete with Dismissible widget

**Advanced Enhancements:**
- [ ] Categories or tags
- [ ] Due dates with date picker
- [ ] Priority levels (high, medium, low)
- [ ] Reorder todos with ReorderableListView

---

## 📖 Key Concepts to Learn

### **1. StatefulWidget Lifecycle**

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // State variables here

  @override
  void initState() {
    super.initState();
    // Called once when widget is created
    // Load data here
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Called every time setState() is called
    return Container();
  }
}
```

**When to use:**
- Widget needs to change over time
- User interaction modifies data
- Data needs to persist during widget lifetime

---

### **2. setState() Deep Dive**

```dart
// WRONG - This won't update the UI
todos.add(newTodo); // State changed but Flutter doesn't know

// CORRECT - Wrap state changes in setState()
setState(() {
  todos.add(newTodo);
});
```

**What setState() does:**
1. Marks widget as "dirty" (needs rebuild)
2. Schedules a rebuild
3. Calls build() method again
4. Flutter compares old and new widget trees
5. Updates only what changed (efficient!)

**Rules:**
- Only call in StatefulWidget's State class
- Keep setState() callbacks fast
- Don't call during build()

---

### **3. Navigation Patterns**

**Basic Navigation:**
```dart
// Push new screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => TodoScreen()),
);

// Pop current screen
Navigator.pop(context);
```

**Passing Data Forward:**
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AddEditTodoScreen(
      todo: existingTodo, // Pass data via constructor
    ),
  ),
);
```

**Returning Data Back:**
```dart
// In AddEditTodoScreen:
Navigator.pop(context, newTodo); // Return data

// In TodoScreen:
final result = await Navigator.push(/*...*/);
if (result != null) {
  setState(() {
    todos.add(result);
  });
}
```

---

### **4. ListView Best Practices**

**For dynamic lists, always use ListView.builder:**
```dart
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    final todo = todos[index];
    return ListTile(
      title: Text(todo.title),
      // Build only visible items - more efficient!
    );
  },
)
```

**Why ListView.builder?**
- Only builds visible items
- Recycles widgets as you scroll
- Handles thousands of items efficiently
- Better memory usage

**Avoid:**
```dart
// DON'T DO THIS for long lists:
ListView(
  children: todos.map((todo) => ListTile(/*...*/)).toList(),
)
// Builds ALL items upfront - slow for large lists!
```

---

### **5. Working with Forms**

```dart
final _formKey = GlobalKey<FormState>();
final _titleController = TextEditingController();

@override
void dispose() {
  _titleController.dispose(); // Always dispose controllers!
  super.dispose();
}

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _titleController,
        decoration: InputDecoration(labelText: 'Title'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a title';
          }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Form is valid, save data
            final title = _titleController.text;
          }
        },
        child: Text('Save'),
      ),
    ],
  ),
)
```

---

### **6. JSON Serialization**

```dart
class Todo {
  // ... fields ...

  // Convert object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create object from JSON map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

// Usage:
// Save
List<String> jsonList = todos.map((t) => jsonEncode(t.toJson())).toList();

// Load
List<Todo> todos = jsonList.map((s) => Todo.fromJson(jsonDecode(s))).toList();
```

---

### **7. Shared Preferences Usage**

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Save
final prefs = await SharedPreferences.getInstance();
await prefs.setStringList('todos', jsonList);

// Load
final prefs = await SharedPreferences.getInstance();
final jsonList = prefs.getStringList('todos') ?? [];

// Clear
await prefs.remove('todos');
```

**What can you save?**
- `int`, `double`, `bool`, `String`
- `List<String>` - use JSON encoding for objects
- Small amounts of data (not for large datasets)

---

## 🧪 Testing Your Implementation

### **Manual Testing Checklist:**

**Counter Screen (Reference):**
- [ ] Counter increments correctly
- [ ] Counter decrements correctly
- [ ] Counter resets to 0
- [ ] UI updates immediately

**Todo Screen:**
- [ ] Opens without errors
- [ ] Shows empty state when no todos
- [ ] FloatingActionButton opens add screen
- [ ] Todos display correctly
- [ ] Checkbox toggles completion
- [ ] Delete button removes todo
- [ ] Tap opens edit screen

**Add/Edit Screen:**
- [ ] Form validates empty title
- [ ] Cancel returns without saving
- [ ] Save creates new todo
- [ ] Edit updates existing todo
- [ ] Navigation works correctly

**Persistence:**
- [ ] Todos save on changes
- [ ] Todos load on app start
- [ ] Data persists after app restart
- [ ] Empty list handled correctly

---

## 🎓 Study Guide

### **Before You Start:**
1. Run the app and explore the counter
2. Read `counter_screen.dart` line by line
3. Understand how setState() works
4. Experiment with the counter code

### **While Building:**
1. Use the counter as a reference
2. Copy patterns, don't copy code
3. Understand each line you write
4. Test frequently as you build

### **After Completion:**
1. Can you explain every line?
2. Try rebuilding from scratch
3. Add one custom feature
4. Compare your code to counter example

---

## 📚 Resources

### **Official Documentation:**
- [Introduction to widgets](https://flutter.dev/docs/development/ui/widgets-intro)
- [StatefulWidget class](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [Navigation and routing](https://flutter.dev/docs/development/ui/navigation)
- [ListView class](https://api.flutter.dev/flutter/widgets/ListView-class.html)

### **Package Documentation:**
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [uuid](https://pub.dev/packages/uuid)

### **Recommended Videos:**
- "Flutter Widgets 101" by Flutter team
- "Flutter State Management - setState" tutorials
- "Todo App Tutorial" (for reference after attempting)

---

## ✅ Completion Criteria

You've completed this project when you can:

- [ ] Build the app without errors
- [ ] Add, edit, delete todos successfully
- [ ] Todos persist after app restart
- [ ] Explain StatefulWidget lifecycle
- [ ] Explain setState() mechanism
- [ ] Explain navigation with data passing
- [ ] Rebuild the todo app from scratch (without looking at your code)

---

## 🚀 Next Steps

After completing this project:

1. **Enhance this app** with optional challenges
2. **Move to Project 2:** [Weather App](../02-weather-app/ROADMAP.md)
3. **Document your learnings** in `shared/research/project-01-notes.md`

---

**Good luck! Remember: The counter is your reference - study it well! 🎯**
