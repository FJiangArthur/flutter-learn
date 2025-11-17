// TODO: Create the TodoScreen widget
//
// This file should implement the main todo list screen
// Study counter_screen.dart as a reference!
//
// Example structure:
//
// import 'package:flutter/material.dart';
// import '../models/todo.dart';
// import '../services/todo_storage.dart';
// import 'add_edit_todo_screen.dart';  // You'll create this too
//
// class TodoScreen extends StatefulWidget {
//   const TodoScreen({super.key});
//
//   @override
//   State<TodoScreen> createState() => _TodoScreenState();
// }
//
// class _TodoScreenState extends State<TodoScreen> {
//   // ═══════════════════════════════════════════════════════════
//   // STATE VARIABLES
//   // ═══════════════════════════════════════════════════════════
//
//   /// List of all todos
//   List<Todo> _todos = [];
//
//   /// Storage service instance
//   final _storage = TodoStorage();
//
//   /// Loading state
//   bool _isLoading = false;
//
//   // ═══════════════════════════════════════════════════════════
//   // LIFECYCLE METHODS
//   // ═══════════════════════════════════════════════════════════
//
//   @override
//   void initState() {
//     super.initState();
//     // TODO: Load todos when screen opens
//     _loadTodos();
//   }
//
//   // ═══════════════════════════════════════════════════════════
//   // DATA METHODS
//   // ═══════════════════════════════════════════════════════════
//
//   /// Load todos from storage
//   Future<void> _loadTodos() async {
//     // TODO: Implement
//     // 1. Set _isLoading to true
//     // 2. Load todos from storage
//     // 3. Update _todos list
//     // 4. Set _isLoading to false
//     // Remember to use setState()!
//   }
//
//   /// Save todos to storage
//   Future<void> _saveTodos() async {
//     // TODO: Implement
//     // Call storage.saveTodos() with current todos list
//   }
//
//   /// Add a new todo
//   void _addTodo(Todo todo) {
//     // TODO: Implement
//     // 1. Add todo to _todos list
//     // 2. Save todos
//     // 3. Wrap in setState()
//   }
//
//   /// Update existing todo
//   void _updateTodo(Todo updatedTodo) {
//     // TODO: Implement
//     // 1. Find todo by ID
//     // 2. Replace with updated version
//     // 3. Save todos
//     // 4. Wrap in setState()
//   }
//
//   /// Toggle todo completion status
//   void _toggleTodoComplete(String todoId) {
//     // TODO: Implement
//     // 1. Find todo by ID
//     // 2. Create updated copy with toggled isCompleted
//     // 3. Replace in list
//     // 4. Save todos
//     // 5. Wrap in setState()
//   }
//
//   /// Delete a todo
//   void _deleteTodo(String todoId) {
//     // TODO: Implement
//     // 1. Remove todo from list
//     // 2. Save todos
//     // 3. Wrap in setState()
//     // 4. Show snackbar confirmation
//   }
//
//   /// Navigate to add/edit screen
//   Future<void> _navigateToAddEdit({Todo? todo}) async {
//     // TODO: Implement
//     // 1. Navigate to AddEditTodoScreen
//     // 2. Pass existing todo if editing
//     // 3. Wait for result
//     // 4. If result is not null, add or update todo
//   }
//
//   // ═══════════════════════════════════════════════════════════
//   // BUILD METHOD
//   // ═══════════════════════════════════════════════════════════
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Todos'),
//         // TODO: Add subtitle showing todo count
//       ),
//       body: _buildBody(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _navigateToAddEdit(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   /// Build the body based on state
//   Widget _buildBody() {
//     // TODO: Implement
//     // If loading, show CircularProgressIndicator
//     // If empty, show empty state message
//     // Otherwise, show ListView.builder with todos
//   }
//
//   /// Build a single todo item
//   Widget _buildTodoItem(Todo todo) {
//     // TODO: Implement
//     // Return Card or ListTile with:
//     // - Checkbox (onChanged: toggle completion)
//     // - Title (with strikethrough if completed)
//     // - Delete button (IconButton)
//     // - onTap: navigate to edit
//   }
// }

// ═══════════════════════════════════════════════════════════
// LEARNING NOTES
// ═══════════════════════════════════════════════════════════
//
// Key concepts to apply from counter_screen.dart:
//
// 1. StatefulWidget structure
//    - Widget class and State class
//    - State variables in State class
//
// 2. setState() usage
//    - Wrap ALL state changes in setState()
//    - UI automatically rebuilds
//
// 3. Lifecycle methods
//    - initState() for loading data
//    - dispose() for cleanup (if needed)
//
// 4. Event handlers
//    - Methods that modify state
//    - Called from UI widgets (buttons, etc.)
//
// 5. Conditional rendering
//    - Show different UI based on state
//    - Loading, empty, data states
//
// Study the counter first, then implement this!
