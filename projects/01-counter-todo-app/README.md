# Project 1: Counter & Todo App

## Quick Start

```bash
cd projects/01-counter-todo-app
flutter pub get
flutter run
```

## 📂 Project Structure

```
lib/
├── main.dart                           # ✅ App entry point (complete)
├── screens/
│   ├── home_screen.dart                # ✅ Navigation hub (complete)
│   ├── counter_screen.dart             # ✅ Counter example (complete - study this!)
│   ├── todo_screen.dart                # ⬜ TODO: Main todo list screen
│   └── add_edit_todo_screen.dart       # ⬜ TODO: Add/edit form screen
├── models/
│   └── todo.dart                       # ⬜ TODO: Todo data model
└── services/
    └── todo_storage.dart               # ⬜ TODO: Persistence service
```

## 🎯 What You Need to Do

### Step 1: Read the Documentation (30 minutes)
1. Open [ROADMAP.md](ROADMAP.md) - Your task list
2. Open [LEARNING_GUIDE.md](LEARNING_GUIDE.md) - Deep concepts
3. Read through both files to understand what you'll build

### Step 2: Study the Counter (30 minutes)
1. Run the app: `flutter run`
2. Navigate to the Counter screen
3. Play with it - click all buttons
4. Open `lib/screens/counter_screen.dart`
5. Read every comment and line of code
6. Understand how setState() works

### Step 3: Implement Todo Model (1 hour)
1. Open `lib/models/todo.dart`
2. Add dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     uuid: ^4.3.3
     shared_preferences: ^2.2.2
   ```
3. Run `flutter pub get`
4. Implement the Todo class
5. Add toJson(), fromJson(), copyWith() methods
6. Test it works

### Step 4: Implement Storage Service (1 hour)
1. Open `lib/services/todo_storage.dart`
2. Implement saveTodos() method
3. Implement loadTodos() method
4. Implement clearTodos() method
5. Test save/load cycle

### Step 5: Build Todo List Screen (2-3 hours)
1. Open `lib/screens/todo_screen.dart`
2. Follow the TODO comments
3. Implement all methods
4. Use counter_screen.dart as reference
5. Build the UI with ListView.builder
6. Test add, toggle, delete operations

### Step 6: Build Add/Edit Screen (1-2 hours)
1. Open `lib/screens/add_edit_todo_screen.dart`
2. Create the form
3. Add validation
4. Handle save and cancel
5. Return data via Navigator.pop()

### Step 7: Connect Everything (30 minutes)
1. Update `lib/screens/home_screen.dart`
2. Uncomment the navigation to TodoScreen
3. Test the complete flow
4. Fix any bugs

## ✅ Testing Checklist

- [ ] Counter works (already implemented)
- [ ] Can navigate to Todo screen
- [ ] Can add a new todo
- [ ] Can see list of todos
- [ ] Can toggle todo completion
- [ ] Can edit existing todo
- [ ] Can delete todo
- [ ] Todos persist after app restart
- [ ] Form validation works
- [ ] Empty state shows when no todos

## 📚 Learning Resources

**Stuck? Check these:**
- [LEARNING_GUIDE.md](LEARNING_GUIDE.md) - Deep dive on concepts
- [Flutter Docs - StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [Flutter Docs - Navigation](https://flutter.dev/docs/development/ui/navigation)
- [shared_preferences Package](https://pub.dev/packages/shared_preferences)

## 🐛 Common Issues

**Issue:** Can't import packages
- **Solution:** Run `flutter pub get`

**Issue:** setState() not updating UI
- **Solution:** Make sure you're calling setState() and modifying state inside the callback

**Issue:** Navigation not working
- **Solution:** Check you're using Navigator.push with MaterialPageRoute

**Issue:** Todos not persisting
- **Solution:** Make sure you're calling saveTodos() after every change

**Issue:** JSON serialization errors
- **Solution:** Check your toJson() and fromJson() implementations match exactly

## 🎓 After Completion

1. **Can you answer these?**
   - What is setState() and how does it work?
   - When is initState() called?
   - How do you pass data between screens?
   - How does ListView.builder differ from ListView?
   - Why must we dispose TextEditingControllers?

2. **Try these challenges:**
   - Add a filter (All, Active, Completed)
   - Add search functionality
   - Add categories or tags
   - Add due dates
   - Implement swipe-to-delete
   - Add undo functionality

3. **Move to next project:**
   - [Project 2: Weather App](../02-weather-app/ROADMAP.md)
   - Document your learnings in `shared/research/project-01-notes.md`

## 🆘 Need Help?

1. Re-read the LEARNING_GUIDE.md
2. Study the counter implementation again
3. Check Flutter documentation
4. Search for specific errors online
5. Break the problem into smaller steps

---

**Remember:** The counter is fully implemented as your reference. When stuck, look at how it solves similar problems!

Good luck! 🚀
