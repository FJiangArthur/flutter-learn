// TODO: Create TodoStorage service class
//
// This file should handle saving and loading todos using shared_preferences
//
// You'll need to:
// 1. Add 'shared_preferences' to pubspec.yaml
// 2. Import shared_preferences package
// 3. Import dart:convert for JSON encoding/decoding
// 4. Import the Todo model
//
// Example structure:
//
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/todo.dart';
//
// class TodoStorage {
//   static const String _todosKey = 'todos';
//
//   /// Save list of todos to persistent storage
//   Future<void> saveTodos(List<Todo> todos) async {
//     // TODO: Implement
//     // 1. Get SharedPreferences instance
//     // 2. Convert each todo to JSON with toJson()
//     // 3. Encode JSON maps to strings with jsonEncode()
//     // 4. Save list of strings with setStringList()
//   }
//
//   /// Load list of todos from persistent storage
//   Future<List<Todo>> loadTodos() async {
//     // TODO: Implement
//     // 1. Get SharedPreferences instance
//     // 2. Get list of JSON strings (or empty list if none)
//     // 3. Decode each string with jsonDecode()
//     // 4. Convert each map to Todo with fromJson()
//     // 5. Return list of todos
//   }
//
//   /// Clear all todos from storage
//   Future<void> clearTodos() async {
//     // TODO: Implement
//     // 1. Get SharedPreferences instance
//     // 2. Remove the todos key
//   }
// }

// Hints:
// - Use async/await for all methods
// - Handle null cases (empty list when no data)
// - Test save/load cycle to ensure data persists
