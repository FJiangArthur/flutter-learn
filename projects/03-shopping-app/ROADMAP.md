# Project 3: Shopping App - Roadmap

## 🎯 Overview
**Difficulty:** Intermediate-Advanced
**Time:** 10-12 hours
**Focus:** State Management (Provider, Riverpod, BLoC)

---

## 🎓 Learning Objectives

- **Provider Pattern:** ChangeNotifier, Consumer, Provider.of()
- **Riverpod:** StateNotifier, AsyncNotifier, Family modifiers
- **BLoC:** Events, States, BlocBuilder, BlocListener
- **Shopping Cart Logic:** Add, remove, calculate totals
- **Persistence:** Save cart with shared_preferences

---

## 🔨 Your Tasks

### **Part A: Build with Provider**

**1. Create Models:**
- `Product` model (id, name, price, image, description)
- `CartItem` model (product, quantity)

**2. Create Providers:**
```dart
// lib/providers/cart_provider.dart
class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  void addItem(Product product) {
    // TODO: Add or increment quantity
    notifyListeners();
  }

  void removeItem(String productId) {
    // TODO: Remove item
    notifyListeners();
  }

  double get totalAmount {
    // TODO: Calculate total
  }
}
```

**3. Build UI:**
- Product list screen
- Product detail screen
- Cart screen with items
- Checkout screen

**4. Use Provider:**
```dart
// Provide at top level
ChangeNotifierProvider(
  create: (_) => CartProvider(),
  child: MyApp(),
)

// Consume in widgets
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return Text('${cart.items.length}');
  },
)
```

---

### **Part B: Rebuild with Riverpod**

**1. Create Providers:**
```dart
// lib/providers/cart_provider.dart (Riverpod version)
@riverpod
class Cart extends _$Cart {
  @override
  List<CartItem> build() => [];

  void addItem(Product product) {
    state = [...state, CartItem(product: product)];
  }

  double totalAmount() {
    // TODO: Calculate
  }
}
```

**2. Use Riverpod:**
```dart
// In widgets
final cart = ref.watch(cartProvider);
ref.read(cartProvider.notifier).addItem(product);
```

---

### **Part C: Rebuild with BLoC**

**1. Create Events:**
```dart
abstract class CartEvent {}
class AddToCart extends CartEvent { final Product product; }
class RemoveFromCart extends CartEvent { final String productId; }
```

**2. Create States:**
```dart
class CartState {
  final List<CartItem> items;
  final double total;
}
```

**3. Create BLoC:**
```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }
}
```

**4. Use BLoC:**
```dart
BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return Text('${state.items.length}');
  },
)
```

---

## 📖 Key Concepts

### **Provider vs Riverpod vs BLoC**

| Feature | Provider | Riverpod | BLoC |
|---------|----------|----------|------|
| Learning Curve | Easy | Medium | Hard |
| Boilerplate | Low | Low | High |
| Type Safety | Medium | High | High |
| Testing | Medium | Easy | Easy |
| Best For | Simple apps | Most apps | Complex apps |

---

## ✅ Completion Criteria

- [ ] Implemented shopping cart with Provider
- [ ] Rebuilt same app with Riverpod
- [ ] Rebuilt same app with BLoC
- [ ] Understand pros/cons of each approach
- [ ] Can explain when to use each pattern
- [ ] Cart persists across app restarts

---

**Next:** [Project 4: Social Feed App](../04-social-feed-app/ROADMAP.md)
