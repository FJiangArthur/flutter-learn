# Challenges: Practice Your Skills

**Tutorial 001** | **Estimated Time:** 15-30 minutes

---

## 🎯 How to Use These Challenges

1. **Start with Challenge 1** (easiest)
2. **Work your way up** through increasing difficulty
3. **Try without looking at hints** first
4. **Check hints** if you're stuck
5. **Compare with solutions** after completing

**Goal:** Reinforce what you learned by building variations!

---

## Challenge 1: Change the Greeting ⭐

### Task
Modify the app to display your name instead of "Hello, Flutter!"

### Expected Result
```
┌─────────────────────┐
│ My First App        │
├─────────────────────┤
│                     │
│  Hello, [YourName]! │
│                     │
└─────────────────────┘
```

### Hints
<details>
<summary>Click to see hint</summary>

Modify the `Text` widget in the `body` of the Scaffold.

```dart
Text('Hello, [YourName]!')
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
body: Center(
  child: Text('Hello, Sarah!'), // Replace with your name
),
```
</details>

---

## Challenge 2: Add Color ⭐

### Task
Change the AppBar background color to your favorite color.

### Expected Result
AppBar should be in a different color (e.g., purple, green, red).

### Hints
<details>
<summary>Click to see hint</summary>

Use the `backgroundColor` property of `AppBar`.

```dart
AppBar(
  title: Text('My First App'),
  backgroundColor: Colors.____,
)
```

Available colors: `red`, `blue`, `green`, `purple`, `orange`, `pink`, `teal`, `amber`
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
appBar: AppBar(
  title: Text('My First App'),
  backgroundColor: Colors.purple,
),
```
</details>

---

## Challenge 3: Style the Text ⭐

### Task
Make the greeting text:
- Larger (font size 32)
- Bold
- Blue color

### Expected Result
"Hello, Flutter!" should be big, bold, and blue.

### Hints
<details>
<summary>Click to see hint</summary>

Use the `style` property of Text with `TextStyle`.

```dart
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: ___,
    fontWeight: FontWeight.___,
    color: Colors.___,
  ),
)
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

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
</details>

---

## Challenge 4: Add Another Text Widget ⭐⭐

### Task
Display two lines of text:
- "Hello, Flutter!" (big and bold)
- "My first app" (small and gray)

### Expected Result
```
┌─────────────────────┐
│ My First App        │
├─────────────────────┤
│                     │
│  Hello, Flutter!    │ ← Big & bold
│  My first app       │ ← Small & gray
│                     │
└─────────────────────┘
```

### Hints
<details>
<summary>Click to see hint</summary>

You need to use a `Column` widget to stack texts vertically:

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(...), // First text
      Text(...), // Second text
    ],
  ),
),
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Hello, Flutter!',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'My first app',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ],
  ),
),
```
</details>

---

## Challenge 5: Add Spacing ⭐⭐

### Task
Add space between the two text widgets from Challenge 4.

### Expected Result
There should be visible space (20 pixels) between the two texts.

### Hints
<details>
<summary>Click to see hint</summary>

Use `SizedBox` with a `height` property:

```dart
children: [
  Text('Hello, Flutter!'),
  SizedBox(height: ___),
  Text('My first app'),
]
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
children: [
  Text(
    'Hello, Flutter!',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  ),
  SizedBox(height: 20),
  Text(
    'My first app',
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
  ),
],
```
</details>

---

## Challenge 6: Add an Icon ⭐⭐

### Task
Add a Flutter logo icon above the text.

### Expected Result
```
┌─────────────────────┐
│ My First App        │
├─────────────────────┤
│       🔷            │ ← Icon
│  Hello, Flutter!    │
│  My first app       │
└─────────────────────┘
```

### Hints
<details>
<summary>Click to see hint</summary>

Use the `Icon` widget with `Icons.flutter_dash`:

```dart
children: [
  Icon(
    Icons.flutter_dash,
    size: ___,
    color: Colors.___,
  ),
  SizedBox(height: 20),
  Text('Hello, Flutter!'),
  // ...
]
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
children: [
  Icon(
    Icons.flutter_dash,
    size: 64,
    color: Colors.blue,
  ),
  SizedBox(height: 20),
  Text(
    'Hello, Flutter!',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  ),
  Text(
    'My first app',
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
  ),
],
```
</details>

---

## Challenge 7: Change Background Color ⭐⭐

### Task
Change the entire screen background to light gray.

### Hints
<details>
<summary>Click to see hint</summary>

Add `backgroundColor` to Scaffold:

```dart
Scaffold(
  backgroundColor: Colors.grey[___],
  appBar: AppBar(...),
  body: Center(...),
)
```

Try values: `50`, `100`, `200` (lighter to darker)
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
Scaffold(
  backgroundColor: Colors.grey[100],
  appBar: AppBar(
    title: Text('My First App'),
  ),
  body: Center(
    // ...
  ),
)
```
</details>

---

## Challenge 8: Create a Welcome Card ⭐⭐⭐

### Task
Put the content in a white card with rounded corners and shadow.

### Expected Result
```
┌─────────────────────┐
│ My First App        │
├─────────────────────┤
│                     │
│  ╔═══════════════╗  │
│  ║   🔷          ║  │ ← Card with shadow
│  ║ Hello, Flutter║  │
│  ║ My first app  ║  │
│  ╚═══════════════╝  │
│                     │
└─────────────────────┘
```

### Hints
<details>
<summary>Click to see hint</summary>

Use a `Container` with decoration:

```dart
Container(
  padding: EdgeInsets.all(32),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Your widgets here
    ],
  ),
)
```
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
body: Center(
  child: Container(
    padding: EdgeInsets.all(32),
    margin: EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.flutter_dash,
          size: 64,
          color: Colors.blue,
        ),
        SizedBox(height: 20),
        Text(
          'Hello, Flutter!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'My first app',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
),
```
</details>

---

## Challenge 9: Add a Button ⭐⭐⭐

### Task
Add a button below the text that shows a message when pressed.

### Expected Result
When you tap the button, a snackbar appears at the bottom saying "Button pressed!"

### Hints
<details>
<summary>Click to see hint</summary>

Use `ElevatedButton` and `ScaffoldMessenger`:

```dart
ElevatedButton(
  onPressed: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Button pressed!')),
    );
  },
  child: Text('Press Me'),
)
```

Add this to your Column's children.
</details>

### Solution
<details>
<summary>Click to see solution</summary>

```dart
children: [
  Icon(
    Icons.flutter_dash,
    size: 64,
    color: Colors.blue,
  ),
  SizedBox(height: 20),
  Text(
    'Hello, Flutter!',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  ),
  Text(
    'My first app',
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
  ),
  SizedBox(height: 24),
  ElevatedButton(
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Button pressed!'),
          duration: Duration(seconds: 2),
        ),
      );
    },
    child: Text('Press Me'),
  ),
],
```
</details>

---

## Challenge 10: Create Your Own Design ⭐⭐⭐

### Task
Create your own unique design using what you've learned!

### Requirements
- Must include at least:
  - 1 Icon
  - 2 Text widgets with different styles
  - 1 Container with decoration
  - Custom colors

### Ideas
- Welcome screen for your favorite hobby
- Personal introduction card
- Motivational quote display
- Mini portfolio

### Example Design
```dart
body: Center(
  child: Container(
    width: 300,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.blue],
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.code, size: 80, color: Colors.white),
        SizedBox(height: 16),
        Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Building beautiful apps',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  ),
),
```

---

## 🎯 Bonus Challenges

### Bonus 1: Multiple Screens
Create a second screen and navigate to it with a button.
(This requires learning about Navigator - preview of Tutorial 002!)

### Bonus 2: Dark Mode
Add a dark theme to your app.

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system, // Follows system setting
)
```

### Bonus 3: Animations
Make the icon bounce when the app starts.
(Preview of Tutorial 015: Animations!)

---

## ✅ Challenge Completion Checklist

Mark off challenges as you complete them:

- [ ] Challenge 1: Change the Greeting
- [ ] Challenge 2: Add Color
- [ ] Challenge 3: Style the Text
- [ ] Challenge 4: Add Another Text Widget
- [ ] Challenge 5: Add Spacing
- [ ] Challenge 6: Add an Icon
- [ ] Challenge 7: Change Background Color
- [ ] Challenge 8: Create a Welcome Card
- [ ] Challenge 9: Add a Button
- [ ] Challenge 10: Create Your Own Design

---

## 🏆 Achievement Unlocked!

Completed all challenges? You've mastered:
- ✅ Basic widgets (Text, Icon, Container)
- ✅ Layouts (Column, Center)
- ✅ Styling (TextStyle, Colors)
- ✅ Decorations (BoxDecoration, shadows)
- ✅ User interaction (Buttons, SnackBars)

**Next Tutorial:** 002 - Understanding Widgets

---

## 💡 Tips

1. **Experiment!** Try changing values and see what happens
2. **Use Hot Reload** to see changes instantly
3. **Read error messages** - they often tell you exactly what's wrong
4. **Check documentation** at [flutter.dev/docs](https://flutter.dev/docs)

**Keep building! The best way to learn is by doing!** 🚀
