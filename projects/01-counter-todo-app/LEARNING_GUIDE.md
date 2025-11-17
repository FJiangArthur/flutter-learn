# Project 1: Counter & Todo App - Learning Guide

## 📚 Deep Dive: Core Flutter Concepts

This guide provides in-depth explanations of the concepts you'll use in this project.

---

## 1. Understanding the Widget Tree

### **Everything in Flutter is a Widget**

```
MaterialApp
  └─ Home
      ├─ AppBar
      │   └─ Text
      └─ Body
          ├─ Counter Button
          │   └─ Text
          └─ Todo Button
              └─ Text
```

**Widget:** A description of part of the UI
**Element:** Instance of a widget in the tree
**RenderObject:** Handles layout and painting

### **Two Types of Widgets**

#### **StatelessWidget - Never Changes**
```dart
class WelcomeText extends StatelessWidget {
  final String name;

  const WelcomeText({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text('Welcome, $name!');
  }
}
```

**Use when:**
- Widget never changes
- All data is final
- No user interaction needed

#### **StatefulWidget - Can Change**
```dart
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0; // Mutable state

  void _increment() {
    setState(() {
      _count++; // Change state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_count');
  }
}
```

**Use when:**
- Widget changes over time
- User interaction modifies data
- Animations or timers

---

## 2. setState() - The Heart of Flutter State Management

### **How setState() Works**

```dart
// 1. Before setState()
int _count = 0;

// 2. User taps button
void _increment() {
  setState(() {      // 3. Marks widget dirty
    _count++;        // 4. Changes state
  });                // 5. Schedules rebuild
}

// 6. build() called again with new state
@override
Widget build(BuildContext context) {
  return Text('$_count'); // 7. Shows new value
}
```

### **setState() Under the Hood**

```dart
void setState(VoidCallback fn) {
  // 1. Mark element as dirty
  _element.markNeedsBuild();

  // 2. Execute state changes
  fn();

  // 3. Schedule a frame
  scheduleMicrotask(() {
    // 4. Rebuild during next frame
    rebuild();
  });
}
```

### **Common setState() Mistakes**

❌ **Mistake 1: Not using setState()**
```dart
void _increment() {
  _count++; // UI WON'T UPDATE!
}
```

❌ **Mistake 2: Async work in setState()**
```dart
void _loadData() {
  setState(() {
    // DON'T DO THIS - setState should be synchronous!
    fetchDataFromApi(); // Async operation
  });
}
```

✅ **Correct:**
```dart
void _loadData() async {
  final data = await fetchDataFromApi();
  setState(() {
    _data = data; // Only state assignment in setState
  });
}
```

❌ **Mistake 3: Calling setState during build**
```dart
@override
Widget build(BuildContext context) {
  setState(() { }); // ERROR! Infinite loop!
  return Text('...');
}
```

---

## 3. Widget Lifecycle

### **StatefulWidget Lifecycle Diagram**

```
createState()
     ↓
initState()          ← Called once when widget inserted
     ↓
didChangeDependencies() ← Called when InheritedWidget changes
     ↓
build()              ← Builds UI
     ↓
┌────────────────────┐
│ Widget is active   │
│                    │
│ setState() → build() ← Can rebuild many times
└────────────────────┘
     ↓
didUpdateWidget()    ← Called when widget configuration changes
     ↓
deactivate()         ← Called when widget removed from tree
     ↓
dispose()            ← Clean up resources (called once)
```

### **Lifecycle Methods Explained**

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late ScrollController _scrollController;

  // 1️⃣ INIT STATE - Called once when widget created
  @override
  void initState() {
    super.initState();
    print('initState: Widget is being created');

    // Initialize state variables
    _scrollController = ScrollController();

    // Start timers, animations
    // Subscribe to streams
    // Load initial data

    // ⚠️ DON'T call setState() here!
    // ⚠️ DON'T access InheritedWidget/context here
  }

  // 2️⃣ DID CHANGE DEPENDENCIES - Called after initState and when dependencies change
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies: Dependencies changed');

    // Access InheritedWidget here
    final theme = Theme.of(context);

    // Called when:
    // - After initState (first time)
    // - When InheritedWidget this widget depends on changes
  }

  // 3️⃣ BUILD - Called many times
  @override
  Widget build(BuildContext context) {
    print('build: Rendering UI');

    // Return your widget tree
    return Container();

    // Called when:
    // - After didChangeDependencies
    // - After setState()
    // - After didUpdateWidget()
    // - When parent rebuilds
  }

  // 4️⃣ DID UPDATE WIDGET - Called when widget configuration changes
  @override
  void didUpdateWidget(MyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget: Widget configuration changed');

    // Compare old and new widget
    if (widget.someProp != oldWidget.someProp) {
      // React to changes
    }
  }

  // 5️⃣ DEACTIVATE - Called when widget removed (temporarily)
  @override
  void deactivate() {
    print('deactivate: Widget removed from tree');
    super.deactivate();

    // Widget might be reinserted
    // Don't clean up yet!
  }

  // 6️⃣ DISPOSE - Called once when widget permanently removed
  @override
  void dispose() {
    print('dispose: Widget being destroyed');

    // Clean up resources
    _scrollController.dispose();
    // Cancel timers
    // Close streams
    // Cancel subscriptions

    super.dispose();

    // ⚠️ Don't call setState() after this!
  }
}
```

### **When Each Method is Called**

```dart
// Scenario 1: Widget first created
createState() → initState() → didChangeDependencies() → build()

// Scenario 2: setState() called
setState() → build()

// Scenario 3: Parent widget rebuilds
build() // Child rebuilds too

// Scenario 4: Widget properties change
didUpdateWidget() → build()

// Scenario 5: Widget removed
deactivate() → dispose()
```

---

## 4. Navigation Deep Dive

### **Navigator Stack Concept**

```
┌─────────────────────┐
│   Edit Screen       │ ← Top (current screen)
├─────────────────────┤
│   Todo List         │
├─────────────────────┤
│   Home Screen       │
└─────────────────────┘
     Navigator Stack
```

**Push:** Add screen on top
**Pop:** Remove top screen

### **Basic Navigation**

```dart
// Push new screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TodoScreen(),
  ),
);

// Pop current screen
Navigator.pop(context);
```

### **Passing Data Forward**

```dart
// Method 1: Constructor parameters
class TodoScreen extends StatelessWidget {
  final String userId;

  const TodoScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Text('User: $userId');
  }
}

// Navigate with data
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TodoScreen(userId: '123'),
  ),
);
```

### **Returning Data from Screen**

```dart
// Screen B: Return data when popping
class AddTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final newTodo = Todo(title: 'Buy milk');
        Navigator.pop(context, newTodo); // Return data
      },
      child: Text('Save'),
    );
  }
}

// Screen A: Receive returned data
class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todos = [];

  void _navigateToAddTodo() async {
    // await the navigation
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTodoScreen()),
    );

    // result is null if user pressed back button
    if (result != null && result is Todo) {
      setState(() {
        _todos.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _navigateToAddTodo,
      child: Icon(Icons.add),
    );
  }
}
```

### **Named Routes**

```dart
// Define routes in MaterialApp
MaterialApp(
  routes: {
    '/': (context) => HomeScreen(),
    '/todos': (context) => TodoScreen(),
    '/add-todo': (context) => AddTodoScreen(),
  },
);

// Navigate using route name
Navigator.pushNamed(context, '/todos');

// Named routes with arguments
Navigator.pushNamed(
  context,
  '/edit-todo',
  arguments: {'todoId': '123'},
);

// Extract arguments
class EditTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final todoId = args['todoId'];

    return Text('Editing: $todoId');
  }
}
```

---

## 5. Working with Lists in Flutter

### **ListView vs ListView.builder**

#### **ListView - Simple, Static Lists**
```dart
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)
```

**Pros:** Simple syntax
**Cons:** Builds all items at once (bad for long lists)

#### **ListView.builder - Dynamic, Efficient Lists**
```dart
ListView.builder(
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(todos[index].title),
    );
  },
)
```

**Pros:**
- Only builds visible items
- Lazy loading
- Excellent performance
- Handles thousands of items

**Cons:** Need to know item count

### **ListView.builder Detailed Example**

```dart
class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({required this.todos});

  @override
  Widget build(BuildContext context) {
    // Handle empty state
    if (todos.isEmpty) {
      return Center(
        child: Text('No todos yet!'),
      );
    }

    return ListView.builder(
      // Required: number of items
      itemCount: todos.length,

      // Optional: add padding
      padding: EdgeInsets.all(16),

      // Optional: customize scroll physics
      physics: BouncingScrollPhysics(),

      // Required: builder function
      itemBuilder: (BuildContext context, int index) {
        // Get item at this index
        final todo = todos[index];

        // Return widget for this item
        return Card(
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                // Handle checkbox change
              },
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted
                  ? TextDecoration.lineThrough
                  : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle delete
              },
            ),
          ),
        );
      },
    );
  }
}
```

### **ListView Performance Tips**

```dart
// ✅ Use const constructors when possible
ListView.builder(
  itemBuilder: (context, index) {
    return const ListTile(
      leading: Icon(Icons.person), // const widget - reused
      title: Text('Fixed text'),
    );
  },
)

// ✅ Add keys for items that can change order
ListView.builder(
  itemBuilder: (context, index) {
    final item = items[index];
    return ListTile(
      key: ValueKey(item.id), // Helps Flutter track items
      title: Text(item.title),
    );
  },
)

// ✅ Use itemExtent if all items same height
ListView.builder(
  itemExtent: 80.0, // All items 80 pixels tall
  itemBuilder: (context, index) {
    return Container(height: 80, /* ... */);
  },
)
```

---

## 6. Forms and Input Validation

### **TextEditingController**

```dart
class MyForm extends StatefulWidget {
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // Create controller
  final _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen to changes
    _titleController.addListener(() {
      print('Text changed: ${_titleController.text}');
    });

    // Set initial value
    _titleController.text = 'Initial value';
  }

  @override
  void dispose() {
    // IMPORTANT: Dispose controller!
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            hintText: 'Enter todo title',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Get current text
            final text = _titleController.text;
            print('Submitted: $text');

            // Clear text
            _titleController.clear();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
```

### **Form Validation**

```dart
class ValidatedForm extends StatefulWidget {
  @override
  State<ValidatedForm> createState() => _ValidatedFormState();
}

class _ValidatedFormState extends State<ValidatedForm> {
  // Form key to access form state
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Form is valid!
      final title = _titleController.text;
      final email = _emailController.text;

      print('Valid! Title: $title, Email: $email');

      // Save data, navigate, etc.
    } else {
      // Form has errors
      print('Form has errors');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Attach form key
      child: Column(
        children: [
          // Title field - required
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              if (value.length < 3) {
                return 'Title must be at least 3 characters';
              }
              return null; // Valid
            },
          ),

          // Email field - required and must be valid email
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null; // Valid
            },
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: _submit,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

### **Input Decoration Options**

```dart
TextFormField(
  decoration: InputDecoration(
    // Label above field when focused
    labelText: 'Title',

    // Helper text below field
    helperText: 'Enter your todo title',

    // Hint inside field when empty
    hintText: 'Buy groceries',

    // Icon at start
    icon: Icon(Icons.title),

    // Prefix inside field
    prefixIcon: Icon(Icons.search),
    prefixText: '\$',

    // Suffix inside field
    suffixIcon: Icon(Icons.clear),
    suffixText: 'USD',

    // Border styles
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),

    // Error text (shown when validation fails)
    errorText: null, // Set by validator
    errorMaxLines: 2,

    // Fill color
    filled: true,
    fillColor: Colors.grey[200],

    // Content padding
    contentPadding: EdgeInsets.all(16),
  ),
)
```

---

## 7. Data Persistence with shared_preferences

### **What is shared_preferences?**

- Simple key-value storage
- Similar to localStorage in web
- Persists data across app restarts
- Good for small amounts of data (settings, simple lists)
- NOT for large datasets (use database instead)

### **Basic Usage**

```dart
import 'package:shared_preferences/shared_preferences.dart';

// Save data
Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();

  // Save different types
  await prefs.setString('username', 'john_doe');
  await prefs.setInt('age', 25);
  await prefs.setBool('isDarkMode', true);
  await prefs.setDouble('rating', 4.5);
  await prefs.setStringList('tags', ['flutter', 'dart']);
}

// Load data
Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();

  // Get data with default values
  final username = prefs.getString('username') ?? 'Guest';
  final age = prefs.getInt('age') ?? 0;
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final rating = prefs.getDouble('rating') ?? 0.0;
  final tags = prefs.getStringList('tags') ?? [];

  print('Username: $username, Age: $age');
}

// Check if key exists
Future<bool> hasUsername() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('username');
}

// Remove data
Future<void> removeData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('username');
}

// Clear all data
Future<void> clearAll() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
```

### **Saving Objects as JSON**

```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({required this.id, required this.title, required this.isCompleted});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Create from JSON
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}

// Save list of todos
Future<void> saveTodos(List<Todo> todos) async {
  final prefs = await SharedPreferences.getInstance();

  // Convert todos to JSON strings
  final List<String> jsonStrings = todos
      .map((todo) => jsonEncode(todo.toJson()))
      .toList();

  await prefs.setStringList('todos', jsonStrings);
}

// Load list of todos
Future<List<Todo>> loadTodos() async {
  final prefs = await SharedPreferences.getInstance();

  // Get JSON strings (empty list if not found)
  final List<String> jsonStrings = prefs.getStringList('todos') ?? [];

  // Convert JSON strings back to Todo objects
  final List<Todo> todos = jsonStrings
      .map((jsonString) => Todo.fromJson(jsonDecode(jsonString)))
      .toList();

  return todos;
}
```

### **Best Practices**

```dart
// ✅ Create a storage service class
class TodoStorage {
  static const String _todosKey = 'todos';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStrings = todos.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_todosKey, jsonStrings);
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStrings = prefs.getStringList(_todosKey) ?? [];
    return jsonStrings
        .map((s) => Todo.fromJson(jsonDecode(s)))
        .toList();
  }

  Future<void> clearTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_todosKey);
  }
}

// Usage in widget
class _TodoScreenState extends State<TodoScreen> {
  final _storage = TodoStorage();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _storage.loadTodos();
    setState(() {
      _todos = todos;
    });
  }

  Future<void> _addTodo(Todo todo) async {
    setState(() {
      _todos.add(todo);
    });
    await _storage.saveTodos(_todos);
  }
}
```

---

## 8. Common Patterns & Best Practices

### **Null Safety**

```dart
// ✅ Nullable type
String? description; // Can be null

// ✅ Non-nullable type
String title; // Cannot be null

// ✅ Null-aware operators
final text = description ?? 'No description'; // Default value
final length = description?.length; // Safe access (returns null if description is null)
final uppercase = description!.toUpperCase(); // Force unwrap (crash if null!)

// ✅ Late initialization
late String apiKey; // Will be initialized before use

void initState() {
  apiKey = loadApiKey(); // Initialize later
}
```

### **Const Constructors**

```dart
// ✅ Use const for immutable widgets
const Text('Hello'); // Reused across rebuilds
const Icon(Icons.add);
const SizedBox(height: 20);

// ✅ Benefits:
// - Better performance
// - Less memory usage
// - Flutter reuses const widgets

// ❌ Can't use const if:
class MyWidget extends StatelessWidget {
  final String name;

  const MyWidget({required this.name}); // ✅ Can be const

  @override
  Widget build(BuildContext context) {
    return Text(name); // ✅ name is final
  }
}
```

### **Async/Await Best Practices**

```dart
// ✅ Loading state pattern
class _MyWidgetState extends State<MyWidget> {
  bool _isLoading = false;
  List<Todo> _todos = [];
  String? _error;

  Future<void> _loadTodos() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final todos = await TodoStorage().loadTodos();
      setState(() {
        _todos = todos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    }

    if (_error != null) {
      return Text('Error: $_error');
    }

    return ListView.builder(/*...*/);
  }
}
```

### **Widget Extraction**

```dart
// ❌ Giant build method
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Container(
          // 50 lines of complex UI...
        ),
        ListView.builder(
          // 50 more lines...
        ),
      ],
    ),
  );
}

// ✅ Extract to methods
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        _buildHeader(),
        _buildTodoList(),
      ],
    ),
  );
}

Widget _buildHeader() {
  return Container(/*...*/);
}

Widget _buildTodoList() {
  return ListView.builder(/*...*/);
}

// ✅ Even better: Extract to separate widgets
class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(/*...*/);
  }
}
```

---

## 🎯 Learning Checklist

After studying this guide, you should understand:

- [ ] Difference between StatelessWidget and StatefulWidget
- [ ] How setState() works and when to use it
- [ ] Complete widget lifecycle (initState to dispose)
- [ ] Navigation with data passing
- [ ] ListView vs ListView.builder
- [ ] Form validation with TextFormField
- [ ] TextEditingController usage and disposal
- [ ] Saving data with shared_preferences
- [ ] JSON serialization (toJson/fromJson)
- [ ] Null safety basics
- [ ] Async/await patterns
- [ ] When to use const constructors

---

**Next:** Apply these concepts in [ROADMAP.md](ROADMAP.md) to build the Todo app!
