# State Management: Provider vs Riverpod vs BLoC

## Quick Comparison

| Aspect | Provider | Riverpod | BLoC |
|--------|----------|----------|------|
| **Learning Curve** | Easy | Medium | Hard |
| **Boilerplate** | Low | Low | High |
| **Type Safety** | Medium | High | High |
| **Testing** | Medium | Easy | Easy |
| **BuildContext Dependency** | Yes | No | Yes (with flutter_bloc) |
| **Compile-time Safety** | No | Yes | Yes |
| **Best For** | Small-medium apps | Most apps | Large/complex apps |

---

## When to Use Each

### **Use Provider When:**
- Building small to medium apps
- You're new to Flutter
- You want minimal boilerplate
- You're comfortable with InheritedWidget concepts
- You don't need complex dependency injection

### **Use Riverpod When:**
- Building any size app (scales well)
- You want compile-time safety
- You need testability without mocking context
- You want auto-disposal of resources
- You need provider dependencies

### **Use BLoC When:**
- Building large enterprise apps
- You need predictable state transitions
- You want separation of business logic from UI
- Team is familiar with reactive programming
- You need detailed state history/debugging

---

## Code Comparison: Counter App

### **Provider**

```dart
// 1. Create Provider
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// 2. Provide at top level
ChangeNotifierProvider(
  create: (_) => CounterProvider(),
  child: MyApp(),
)

// 3. Consume in widget
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counter, child) {
        return Text('${counter.count}');
      },
    );
  }
}

// 4. Modify state
Provider.of<CounterProvider>(context, listen: false).increment();
// or
context.read<CounterProvider>().increment();
```

**Pros:**
- Simple and intuitive
- Low boilerplate
- Good documentation
- Large community

**Cons:**
- Requires BuildContext
- Runtime errors if provider not found
- Manual disposal needed
- Can be hard to test

---

### **Riverpod**

```dart
// 1. Create Provider
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}

// 2. No need to provide at top level!
// Providers are global

// 3. Consume in widget
class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}

// 4. Modify state
ref.read(counterProvider.notifier).increment();
```

**Pros:**
- No BuildContext needed
- Compile-time safety
- Auto-disposal
- Easy testing
- Better DevTools support

**Cons:**
- Newer (smaller community)
- Requires code generation for complex providers
- Different from standard Flutter patterns

---

### **BLoC**

```dart
// 1. Define Events
abstract class CounterEvent {}
class Increment extends CounterEvent {}

// 2. Define States
class CounterState {
  final int count;
  CounterState(this.count);
}

// 3. Create BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<Increment>((event, emit) {
      emit(CounterState(state.count + 1));
    });
  }
}

// 4. Provide at top level
BlocProvider(
  create: (_) => CounterBloc(),
  child: MyApp(),
)

// 5. Consume in widget
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Text('${state.count}');
      },
    );
  }
}

// 6. Trigger events
context.read<CounterBloc>().add(Increment());
```

**Pros:**
- Clear separation of concerns
- Predictable state transitions
- Excellent for complex state
- Great debugging with Bloc Observer
- Testable

**Cons:**
- High boilerplate
- Steep learning curve
- Overkill for simple apps
- More files to manage

---

## Shopping Cart Example

### **Provider**

```dart
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  double get total => _items.fold(
    0,
    (sum, item) => sum + (item.price * item.quantity),
  );

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((i) => i.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem.fromProduct(product));
    }

    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

// Usage
Consumer<CartProvider>(
  builder: (context, cart, child) {
    return Text('Total: \$${cart.total}');
  },
)
```

---

### **Riverpod**

```dart
@riverpod
class Cart extends _$Cart {
  @override
  List<CartItem> build() => [];

  void addItem(Product product) {
    final existingIndex = state.indexWhere((i) => i.id == product.id);

    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem.fromProduct(product)];
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

// Derived provider for total
@riverpod
double cartTotal(CartTotalRef ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
}

// Usage
class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Text('Total: \$$total');
  }
}
```

---

### **BLoC**

```dart
// Events
abstract class CartEvent {}
class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}
class RemoveFromCart extends CartEvent {
  final String id;
  RemoveFromCart(this.id);
}

// State
class CartState {
  final List<CartItem> items;
  final double total;

  CartState({required this.items, required this.total});
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [], total: 0)) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final existingIndex = items.indexWhere((i) => i.id == event.product.id);

    if (existingIndex >= 0) {
      items[existingIndex] = items[existingIndex].copyWith(
        quantity: items[existingIndex].quantity + 1,
      );
    } else {
      items.add(CartItem.fromProduct(event.product));
    }

    final total = _calculateTotal(items);
    emit(CartState(items: items, total: total));
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
}

// Usage
BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return Text('Total: \$${state.total}');
  },
)
```

---

## Migration Path

### **From Provider to Riverpod:**

**Provider:**
```dart
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

ChangeNotifierProvider(create: (_) => CounterProvider())
Consumer<CounterProvider>(builder: ...)
```

**Riverpod:**
```dart
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  void increment() => state++;
}

// No provider needed
ref.watch(counterProvider)
```

---

## Recommendation

For this learning repository:

1. **Start with Provider** (Project 3) - Easiest to learn
2. **Then try Riverpod** (Project 3) - Modern and powerful
3. **Then BLoC** (Project 3) - Enterprise patterns

For real projects:
- **Small app?** Provider or Riverpod
- **Medium app?** Riverpod
- **Large app?** Riverpod or BLoC
- **Team with React experience?** Provider or Riverpod
- **Team with Redux experience?** BLoC

**My recommendation: Learn Riverpod.** It's the modern approach that solves Provider's problems while being simpler than BLoC.
