# Project 8: E-Commerce MVP - Roadmap

## 🎯 Overview
**Difficulty:** Production-Ready
**Time:** 25-30 hours
**Focus:** Complete App with Clean Architecture, Testing, App Store Deployment

---

## 🎓 Learning Objectives

- Clean Architecture (Data, Domain, Presentation layers)
- Feature-first folder structure
- Dependency injection
- Payment integration
- App Store submission process
- Code signing and provisioning
- TestFlight distribution
- Production-ready code quality

---

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── products/
│   ├── cart/
│   ├── orders/
│   └── profile/
└── main.dart
```

---

## 🔨 Your Tasks

### **Phase 1: Setup & Architecture (Day 1-2)**

**1. Create Folder Structure**

**2. Setup Dependencies:**
```yaml
dependencies:
  # State Management
  flutter_bloc: ^8.1.3
  # or riverpod: ^2.4.9

  # Network
  dio: ^5.4.0
  retrofit: ^4.0.3

  # Local Storage
  hive: ^2.2.3
  shared_preferences: ^2.2.2

  # DI
  get_it: ^7.6.4
  injectable: ^2.3.2

  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0

  # Payment
  stripe_payment: ^1.1.5
  # or pay: ^1.1.2  # For Apple Pay

  # UI
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.7
  injectable_generator: ^2.4.1

  # Testing
  mockito: ^5.4.4
  bloc_test: ^9.1.5
```

**3. Setup Dependency Injection:**
```dart
// lib/injection.dart
@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();
}

// Register services
@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
```

---

### **Phase 2: Authentication (Day 3-4)**

**Features:**
- [ ] Email/password sign up
- [ ] Email/password login
- [ ] Google Sign-In
- [ ] Apple Sign-In (required for iOS)
- [ ] Email verification
- [ ] Password reset
- [ ] Session management
- [ ] Auto login

**Entity:**
```dart
// domain/entities/user.dart
class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });
}
```

**Use Case Example:**
```dart
// domain/usecases/sign_in.dart
class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(email, password);
  }
}
```

**BLoC:**
```dart
// presentation/bloc/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;

  AuthBloc({required this.signIn, required this.signUp})
      : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signIn(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }
}
```

---

### **Phase 3: Products (Day 5-7)**

**Features:**
- [ ] Product catalog with categories
- [ ] Product search
- [ ] Filters (price, category, rating)
- [ ] Sort (price, popularity, newest)
- [ ] Product details with image gallery
- [ ] Reviews and ratings
- [ ] Recently viewed
- [ ] Favorites/Wishlist

**Product Entity:**
```dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String category;
  final double rating;
  final int reviewCount;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.stock,
  });
}
```

**UI Components:**
- Product grid with shimmer loading
- Search bar with debounce
- Filter bottom sheet
- Image carousel for product details
- Rating stars widget
- Add to cart button with animation

---

### **Phase 4: Shopping Cart (Day 8-9)**

**Features:**
- [ ] Add/remove products
- [ ] Update quantity
- [ ] Calculate subtotal
- [ ] Apply discount codes
- [ ] Calculate tax
- [ ] Calculate shipping
- [ ] Persist cart locally
- [ ] Sync with backend

**Cart Logic:**
```dart
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ApplyDiscount>(_onApplyDiscount);
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedItems = List<CartItem>.from(currentState.items);

      // Check if product already in cart
      final existingIndex = updatedItems.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (existingIndex != -1) {
        // Update quantity
        updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
          quantity: updatedItems[existingIndex].quantity + 1,
        );
      } else {
        // Add new item
        updatedItems.add(CartItem(product: event.product, quantity: 1));
      }

      emit(CartLoaded(
        items: updatedItems,
        subtotal: _calculateSubtotal(updatedItems),
        tax: _calculateTax(updatedItems),
        shipping: _calculateShipping(updatedItems),
      ));

      // Persist to local storage
      await _saveCart(updatedItems);
    }
  }
}
```

---

### **Phase 5: Checkout & Payment (Day 10-12)**

**Features:**
- [ ] Address management
- [ ] Shipping method selection
- [ ] Payment method selection
- [ ] Stripe integration
- [ ] Apple Pay (iOS)
- [ ] Order summary
- [ ] Order confirmation

**Stripe Setup:**
```dart
import 'package:stripe_payment/stripe_payment.dart';

// Initialize
StripePayment.setOptions(
  StripeOptions(
    publishableKey: "pk_test_YOUR_KEY",
    merchantId: "your_merchant_id",
    androidPayMode: 'test',
  ),
);

// Create payment
Future<void> processPayment(double amount) async {
  try {
    // Create payment method
    final paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    );

    // Create payment intent on backend
    final paymentIntent = await createPaymentIntent(amount);

    // Confirm payment
    final response = await StripePayment.confirmPaymentIntent(
      PaymentIntent(
        clientSecret: paymentIntent['client_secret'],
        paymentMethodId: paymentMethod.id,
      ),
    );

    if (response.status == 'succeeded') {
      // Payment successful
      await createOrder();
    }
  } catch (e) {
    // Handle error
  }
}
```

**Apple Pay (iOS):**
```dart
// Configure in Xcode:
// 1. Enable Apple Pay capability
// 2. Add merchant ID
// 3. Create certificates

import 'package:pay/pay.dart';

final applePayButton = ApplePayButton(
  paymentConfiguration: PaymentConfiguration.fromJsonString(
    defaultApplePay,
  ),
  onPaymentResult: (result) {
    // Handle payment
  },
);
```

---

### **Phase 6: Orders & Profile (Day 13-14)**

**Features:**
- [ ] Order history
- [ ] Order details
- [ ] Order tracking
- [ ] Cancel order
- [ ] User profile
- [ ] Edit profile
- [ ] Settings
- [ ] Logout

---

### **Phase 7: Testing (Day 15-17)**

**Unit Tests:**
```dart
// test/features/auth/domain/usecases/sign_in_test.dart
void main() {
  late SignIn usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignIn(mockRepository);
  });

  test('should return User when sign in is successful', () async {
    // Arrange
    when(mockRepository.signIn(any, any))
        .thenAnswer((_) async => Right(tUser));

    // Act
    final result = await usecase(email: 'test@test.com', password: 'pass');

    // Assert
    expect(result, Right(tUser));
    verify(mockRepository.signIn('test@test.com', 'pass'));
  });
}
```

**Widget Tests:**
```dart
testWidgets('Login button triggers sign in', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(home: LoginScreen()),
  );

  await tester.enterText(find.byKey(Key('email')), 'test@test.com');
  await tester.enterText(find.byKey(Key('password')), 'password');
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();

  // Verify sign in was called
});
```

---

### **Phase 8: iOS Build & Deployment (Day 18-20)**

**1. Configure Xcode Project:**

Open `ios/Runner.xcworkspace` in Xcode:

- Set Bundle Identifier (e.g., `com.yourcompany.appname`)
- Set Display Name
- Set Version (matches pubspec.yaml)
- Set Build Number
- Select Development Team
- Configure Signing (Automatic or Manual)

**2. Configure Info.plist:**

Add all required usage descriptions:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access for profile photos</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>We need location for shipping</string>
```

**3. Create Privacy Manifest:**

iOS 17+ requires Privacy Manifest for App Store submission.

**4. Build for iOS:**
```bash
# Clean
flutter clean

# Get dependencies
flutter pub get

# Build IPA
flutter build ipa --release

# or build without signing first
flutter build ios --release --no-codesign
```

**5. App Store Connect Setup:**

- Create App Record
- Fill in metadata:
  - App name
  - Subtitle
  - Description
  - Keywords
  - Screenshots (required sizes)
  - Privacy policy URL
  - Support URL

**6. Upload to TestFlight:**

```bash
# Option 1: Use Transporter app (from Mac App Store)
# - Open build/ios/archive/Runner.xcarchive
# - Validate and upload

# Option 2: Use Xcode
# - Open ios/Runner.xcworkspace
# - Product > Archive
# - Distribute App > App Store Connect
```

**7. TestFlight Testing:**

- Add internal testers (up to 100)
- Add external testers (requires Beta App Review)
- Collect feedback
- Fix bugs
- Upload new builds as needed

**8. Submit for Review:**

- Fill in App Review Information
- Add demo account if needed
- Submit for review
- Monitor status in App Store Connect

---

## 📱 iOS-Specific Checklist

- [ ] Bundle ID registered on Developer Portal
- [ ] App created in App Store Connect
- [ ] Development certificate configured
- [ ] Distribution certificate configured
- [ ] Provisioning profiles created
- [ ] Code signing configured in Xcode
- [ ] All capabilities enabled (Apple Pay, etc.)
- [ ] Privacy descriptions added to Info.plist
- [ ] Privacy Manifest created
- [ ] App icons added (all sizes)
- [ ] Launch screen created
- [ ] Screenshots prepared (all required sizes)
- [ ] Privacy policy URL added
- [ ] Support URL added
- [ ] Age rating completed
- [ ] Pricing configured
- [ ] Build uploaded to TestFlight
- [ ] TestFlight testing completed
- [ ] Submitted for App Review

---

## ✅ Completion Criteria

**Functionality:**
- [ ] User can sign up and log in
- [ ] Can browse products
- [ ] Can search and filter
- [ ] Can add to cart
- [ ] Can checkout and pay
- [ ] Can view orders
- [ ] Can manage profile
- [ ] All features work offline (gracefully)

**Code Quality:**
- [ ] Clean architecture implemented
- [ ] All features have unit tests
- [ ] Key screens have widget tests
- [ ] No lint warnings
- [ ] Code documented
- [ ] Error handling comprehensive

**Production Ready:**
- [ ] App builds without errors
- [ ] No console warnings
- [ ] Performance optimized (60 FPS)
- [ ] App size optimized
- [ ] Security best practices followed
- [ ] API keys secured
- [ ] Analytics integrated

**iOS Deployment:**
- [ ] Builds successfully for iOS
- [ ] Runs on physical iOS device
- [ ] TestFlight build uploaded
- [ ] TestFlight testing completed
- [ ] Ready for App Store submission

---

## 🎓 You've Completed All Projects!

Congratulations! You now have:

✅ Mastered Flutter fundamentals
✅ Expert in state management patterns
✅ Skilled in API integration and async programming
✅ Proficient in advanced UI and animations
✅ Experienced with Firebase and real-time data
✅ Knowledgeable in platform-specific integration
✅ Capable of multimedia handling
✅ Ready to build production apps
✅ Experienced with App Store deployment

---

## 🚀 Next Steps

1. **Polish This App:** Add more features, improve UX
2. **Publish to App Store:** Complete the submission
3. **Build Your Own App:** Apply everything you learned
4. **Contribute to Open Source:** Help other Flutter developers
5. **Keep Learning:** Flutter is always evolving!

---

**You're now a Flutter & iOS Developer! 🎉**
