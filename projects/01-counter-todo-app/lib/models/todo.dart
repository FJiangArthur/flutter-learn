// TODO: Create the Todo model class
//
// This file should contain a Todo class with:
// - String id (unique identifier)
// - String title (todo title)
// - String? description (optional description)
// - bool isCompleted (completion status)
// - DateTime createdAt (creation timestamp)
//
// Also implement:
// - toJson() method to convert to Map<String, dynamic>
// - fromJson() factory constructor to create from Map<String, dynamic>
// - copyWith() method for creating modified copies
//
// Example structure:
//
// class Todo {
//   final String id;
//   final String title;
//   final String? description;
//   final bool isCompleted;
//   final DateTime createdAt;
//
//   Todo({
//     required this.id,
//     required this.title,
//     this.description,
//     this.isCompleted = false,
//     DateTime? createdAt,
//   }) : createdAt = createdAt ?? DateTime.now();
//
//   Map<String, dynamic> toJson() {
//     // TODO: Implement JSON serialization
//   }
//
//   factory Todo.fromJson(Map<String, dynamic> json) {
//     // TODO: Implement JSON deserialization
//   }
//
//   Todo copyWith({
//     String? id,
//     String? title,
//     String? description,
//     bool? isCompleted,
//     DateTime? createdAt,
//   }) {
//     // TODO: Implement copyWith for immutable updates
//   }
// }

// Hint: You'll need to:
// 1. Add 'uuid' package to pubspec.yaml
// 2. Use Uuid().v4() to generate unique IDs
// 3. Use DateTime.parse() and toIso8601String() for JSON conversion
