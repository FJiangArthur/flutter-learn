// TODO: Create the AddEditTodoScreen widget
//
// This screen is used for both adding new todos and editing existing ones
//
// Example structure:
//
// import 'package:flutter/material.dart';
// import '../models/todo.dart';
//
// class AddEditTodoScreen extends StatefulWidget {
//   /// The todo to edit (null if adding new)
//   final Todo? todo;
//
//   const AddEditTodoScreen({super.key, this.todo});
//
//   @override
//   State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
// }
//
// class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
//   // ═══════════════════════════════════════════════════════════
//   // FORM STATE
//   // ═══════════════════════════════════════════════════════════
//
//   /// Form key for validation
//   final _formKey = GlobalKey<FormState>();
//
//   /// Controller for title field
//   late TextEditingController _titleController;
//
//   /// Controller for description field
//   late TextEditingController _descriptionController;
//
//   /// Is this editing or adding?
//   bool get _isEditing => widget.todo != null;
//
//   // ═══════════════════════════════════════════════════════════
//   // LIFECYCLE METHODS
//   // ═══════════════════════════════════════════════════════════
//
//   @override
//   void initState() {
//     super.initState();
//
//     // TODO: Initialize controllers
//     // If editing, set initial values from widget.todo
//     // Example:
//     // _titleController = TextEditingController(
//     //   text: widget.todo?.title ?? '',
//     // );
//   }
//
//   @override
//   void dispose() {
//     // TODO: Dispose controllers to prevent memory leaks
//     // _titleController.dispose();
//     // _descriptionController.dispose();
//     super.dispose();
//   }
//
//   // ═══════════════════════════════════════════════════════════
//   // FORM METHODS
//   // ═══════════════════════════════════════════════════════════
//
//   /// Validate and save the form
//   void _saveForm() {
//     // TODO: Implement
//     // 1. Validate form using _formKey.currentState!.validate()
//     // 2. If valid, create Todo object
//     //    - If editing: use existing ID and createdAt
//     //    - If adding: generate new ID, set createdAt to now
//     // 3. Pop with the todo as result: Navigator.pop(context, todo)
//   }
//
//   /// Cancel and go back
//   void _cancel() {
//     // TODO: Implement
//     // Show confirmation dialog if form has changes?
//     // Then Navigator.pop(context) without result
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
//         // TODO: Show "Add Todo" or "Edit Todo" based on _isEditing
//         title: Text(_isEditing ? 'Edit Todo' : 'Add Todo'),
//         actions: [
//           // Save button in app bar
//           TextButton(
//             onPressed: _saveForm,
//             child: const Text('SAVE'),
//           ),
//         ],
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // TODO: Add TextFormField for title
//             // - Use _titleController
//             // - Add validator (required, min length)
//             // - Decoration with label and hint
//
//             const SizedBox(height: 16),
//
//             // TODO: Add TextFormField for description
//             // - Use _descriptionController
//             // - Make it optional (no validator needed)
//             // - Make it multiline (maxLines: 5)
//             // - Decoration with label and hint
//
//             const SizedBox(height: 24),
//
//             // TODO: Add buttons
//             // Row with Save and Cancel buttons
//           ],
//         ),
//       ),
//     );
//   }
// }

// ═══════════════════════════════════════════════════════════
// LEARNING NOTES
// ═══════════════════════════════════════════════════════════
//
// Key concepts for this screen:
//
// 1. TextEditingController
//    - One controller per text field
//    - Initialize in initState()
//    - Dispose in dispose()
//    - Get text with controller.text
//
// 2. Form validation
//    - Create GlobalKey<FormState>
//    - Wrap fields in Form widget
//    - Use TextFormField (not TextField)
//    - Implement validator functions
//    - Call _formKey.currentState!.validate()
//
// 3. Navigation with results
//    - Pass todo in constructor for editing
//    - Return todo when saving: Navigator.pop(context, todo)
//    - Return null when canceling: Navigator.pop(context)
//
// 4. Conditional UI
//    - Show different title based on add/edit
//    - Pre-fill fields if editing
//    - Use same screen for both modes
//
// See LEARNING_GUIDE.md for detailed examples!
