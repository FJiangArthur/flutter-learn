# Project 5: Chat Application - Roadmap

## 🎯 Overview
**Difficulty:** Advanced
**Time:** 15-20 hours
**Focus:** Firebase, Real-time Data, Local Database, Push Notifications

---

## 🎓 Learning Objectives

- Firebase Authentication
- Cloud Firestore real-time listeners
- sqflite local database
- Push notifications (FCM)
- Background tasks
- StreamBuilder widget
- Chat UI patterns

---

## 🔨 Your Tasks

### **Task 1: Firebase Setup**

**1. Create Firebase Project:**
- Go to [Firebase Console](https://console.firebase.google.com/)
- Create new project
- Add iOS and Android apps
- Download config files

**2. Add Firebase to Flutter:**
```yaml
# pubspec.yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_messaging: ^14.7.0
```

**3. Initialize:**
```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

---

### **Task 2: Implement Authentication**

```dart
// lib/services/auth_service.dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign in
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
```

---

### **Task 3: Firestore Real-time Chat**

**Data Structure:**
```
users/
  userId1/
    name: "John"
    email: "john@email.com"

chats/
  chatId1/
    participants: ["userId1", "userId2"]
    lastMessage: "Hey!"
    timestamp: 1234567890

messages/
  chatId1/
    messageId1/
      text: "Hello!"
      senderId: "userId1"
      timestamp: 1234567890
      read: false
```

**Send Message:**
```dart
Future<void> sendMessage(String chatId, String text) async {
  final user = FirebaseAuth.instance.currentUser!;

  await FirebaseFirestore.instance
      .collection('messages')
      .doc(chatId)
      .collection('messages')
      .add({
    'text': text,
    'senderId': user.uid,
    'timestamp': FieldValue.serverTimestamp(),
    'read': false,
  });

  // Update last message in chat
  await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
    'lastMessage': text,
    'timestamp': FieldValue.serverTimestamp(),
  });
}
```

**Listen to Messages:**
```dart
Stream<List<Message>> getMessages(String chatId) {
  return FirebaseFirestore.instance
      .collection('messages')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
}
```

---

### **Task 4: Build Chat UI with StreamBuilder**

```dart
class ChatScreen extends StatelessWidget {
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: FirestoreService().getMessages(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }

                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(message: message);
                  },
                );
              },
            ),
          ),

          // Message input
          MessageInput(chatId: chatId),
        ],
      ),
    );
  }
}
```

---

### **Task 5: Local Database with sqflite**

**Why local database?**
- Offline access to messages
- Faster loading
- Reduce Firestore reads (save costs)

**Setup:**
```dart
// lib/services/local_db.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'chat.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create tables
        db.execute('''
          CREATE TABLE messages(
            id TEXT PRIMARY KEY,
            chatId TEXT,
            text TEXT,
            senderId TEXT,
            timestamp INTEGER,
            read INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertMessage(Message message) async {
    final db = await database;
    await db.insert('messages', message.toMap());
  }

  Future<List<Message>> getMessages(String chatId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'chatId = ?',
      whereArgs: [chatId],
      orderBy: 'timestamp DESC',
    );

    return maps.map((map) => Message.fromMap(map)).toList();
  }
}
```

**Sync Strategy:**
1. Load from local DB first (instant)
2. Listen to Firestore for updates
3. Save Firestore updates to local DB

---

### **Task 6: Push Notifications**

**Setup FCM:**
```dart
// lib/services/notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // Request permission
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    String? token = await _fcm.getToken();
    print('FCM Token: $token');

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      // Show local notification
    });

    // Handle notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Navigate to chat screen
    });
  }
}
```

---

### **Task 7: Additional Features**

**Typing Indicator:**
```dart
void updateTypingStatus(String chatId, bool isTyping) {
  FirebaseFirestore.instance.collection('chats').doc(chatId).update({
    'typingUsers': isTyping
        ? FieldValue.arrayUnion([userId])
        : FieldValue.arrayRemove([userId]),
  });
}
```

**Read Receipts:**
```dart
void markAsRead(String chatId, String messageId) {
  FirebaseFirestore.instance
      .collection('messages')
      .doc(chatId)
      .collection('messages')
      .doc(messageId)
      .update({'read': true});
}
```

**Image Sharing:**
```dart
// Upload to Firebase Storage
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File image) async {
  final ref = FirebaseStorage.instance
      .ref()
      .child('chat_images')
      .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

  await ref.putFile(image);
  return await ref.getDownloadURL();
}
```

---

## ✅ Completion Criteria

- [ ] User can sign up and sign in
- [ ] Real-time messaging works
- [ ] Messages persist offline
- [ ] Push notifications received
- [ ] Typing indicator works
- [ ] Read receipts work
- [ ] Can send images
- [ ] Chat list shows recent chats
- [ ] Messages load from local DB first
- [ ] Firestore security rules set up

---

**Next:** [Project 6: Maps & Location App](../06-maps-location-app/ROADMAP.md)
