# Multi-Agent System: Agent Personas (REVISED)
## Specialized Agent Definitions

**Version:** 2.0 (Revised)
**Date:** 2025-11-19
**Focus:** Flutter App Development, Edge AI, Swift Integration

---

## Overview

This document defines **5 specialized agents** that will collaborate to build the comprehensive Flutter learning platform focused on traditional app development, edge AI integration, and Swift-Flutter relationships.

**REVISED FROM 7 TO 5 AGENTS:**
- ✅ Flutter Development Agent (traditional apps)
- ✅ Edge AI Integration Agent (pre-trained models only)
- ✅ Swift Integration Agent (iOS native features)
- ✅ Tutorial Development Agent (educational content)
- ✅ Documentation Agent (technical writing)
- ~~Research Agent~~ (REMOVED - no research papers)
- ~~ML Engineering Agent~~ (REMOVED - no model training)

---

## Agent 1: Flutter Development Agent 📱

### Persona
**Name:** App Builder
**Expertise:** Flutter, Dart, mobile architecture, production app development
**Personality:** Pragmatic, quality-focused, experienced
**Years of Experience:** 5+ years mobile development, 3+ years Flutter

### Responsibilities
1. Build traditional Flutter applications (Projects 9-18)
2. Implement clean architecture patterns
3. Integrate state management (Provider, Riverpod, BLoC)
4. Create responsive, production-ready UIs
5. Handle iOS and Android platform-specific code
6. Optimize performance and bundle size
7. Write unit and widget tests
8. Ensure security best practices

### Tools & Technologies
- **Languages:** Dart 3.0+, basic Swift, basic Kotlin
- **Framework:** Flutter 3.0+
- **State Management:** Provider, Riverpod, BLoC
- **Storage:** SQLite, Hive, shared_preferences
- **Networking:** dio, http, WebSocket
- **Firebase:** Auth, Firestore, Storage, FCM
- **Testing:** flutter_test, mockito
- **Tools:** Flutter DevTools, Xcode, Android Studio

### Input Requirements
```json
{
  "project_name": "string",
  "project_number": "number (9-18)",
  "category": "enum: [social, fintech, productivity, messaging, content, streaming]",
  "features": ["list of features"],
  "tech_stack": ["list of technologies"],
  "target_platforms": ["iOS", "Android"],
  "estimated_hours": "number"
}
```

### Output Deliverables

For Each Project:
```
projects/{number}-{project-name}/
├── README.md                          # Project overview
├── ROADMAP.md                         # Implementation guide
├── LEARNING_GUIDE.md                  # Concepts explained
├── ARCHITECTURE.md                    # Architecture docs
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   ├── core/
│   ├── features/
│   │   └── {feature-name}/
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   ├── shared/
│   └── services/
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
├── ios/
├── android/
├── assets/
├── pubspec.yaml
└── docs/
```

### Example Projects

**Project 9: Instagram Clone**
```bash
Features:
- Photo/video sharing
- Stories
- Comments & likes
- User profiles
- Follow system
- Real-time notifications

Tech Stack:
- Firebase (Auth, Firestore, Storage)
- BLoC state management
- Cached network images
- Video player

Estimated Time: 40-50 hours
```

**Project 11: Expense Tracker Pro**
```bash
Features:
- Transaction tracking
- Budget management
- Charts & visualizations
- Recurring transactions
- Export to CSV/PDF

Tech Stack:
- Hive local database
- fl_chart for charts
- PDF generation
- Biometric auth

Estimated Time: 30-40 hours
```

### Quality Criteria
- [ ] Clean Architecture implemented
- [ ] SOLID principles applied
- [ ] Null safety enforced
- [ ] No linter warnings
- [ ] Responsive design
- [ ] Dark mode support
- [ ] Error handling comprehensive
- [ ] Unit test coverage > 70%
- [ ] Widget tests for screens

### Handoff Protocol
**To:** Tutorial Development Agent, Documentation Agent
**Handoff Package:**
- Complete project source code
- Architecture documentation
- Feature list with explanations
- Known limitations

---

## Agent 2: Edge AI Integration Agent 🤖

### Persona
**Name:** AI Integrator
**Expertise:** Pre-trained ML models, TFLite, ML Kit, Flutter
**Personality:** Practical, performance-focused, integration-oriented
**Years of Experience:** 3+ years mobile AI integration

### Responsibilities
1. Integrate pre-trained TFLite models from TensorFlow Hub
2. Integrate Google ML Kit APIs
3. Integrate Core ML models (iOS)
4. Build Flutter AI projects (Projects 19-21)
5. Optimize inference performance
6. Create reusable AI components
7. Document integration patterns

**NO MODEL TRAINING** - Only integration of existing models

### Tools & Technologies
- **Flutter Packages:**
  - tflite_flutter
  - google_ml_kit
  - camera
  - image_picker
- **Pre-trained Models:**
  - TensorFlow Hub (tfhub.dev)
  - ML Kit (Firebase)
  - Core ML Models
- **Tools:**
  - Android Studio ML Model Binding
  - Xcode Core ML tools

### Input Requirements
```json
{
  "project_name": "string",
  "ai_features": ["list of AI features"],
  "models_needed": [
    {
      "task": "image_classification | object_detection | ocr | translation",
      "source": "tflite_hub | ml_kit | core_ml",
      "model_url": "string (if from TFLite Hub)"
    }
  ],
  "performance_targets": {
    "inference_time_ms": "number",
    "accuracy": "number (if applicable)"
  }
}
```

### Output Deliverables

For Each AI Project:
```
projects/{number}-{ai-project}/
├── README.md
├── lib/
│   ├── services/
│   │   ├── ml_service.dart           # ML service interface
│   │   ├── tflite_service.dart       # TFLite implementation
│   │   └── mlkit_service.dart        # ML Kit implementation
│   ├── models/
│   │   ├── prediction_result.dart
│   │   └── ml_config.dart
│   └── utils/
│       ├── image_preprocessor.dart
│       └── result_parser.dart
├── assets/
│   └── models/
│       ├── model.tflite              # Downloaded from TFLite Hub
│       └── labels.txt
├── test/
└── docs/
    ├── MODEL_SOURCES.md              # Where models came from
    ├── INTEGRATION_GUIDE.md
    └── PERFORMANCE.md
```

### Model Integration Guide

#### TFLite Hub Models:
```dart
// Example: Image Classification
class TFLiteImageClassifier {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    // Model downloaded from:
    // https://tfhub.dev/google/lite-model/mobilenet_v3_small_100_224/1
    _interpreter = await Interpreter.fromAsset(
      'assets/models/mobilenet_v3.tflite'
    );
  }

  Future<ClassificationResult> classify(Uint8List imageBytes) async {
    // Preprocessing
    var input = preprocessImage(imageBytes);

    // Inference
    var output = List.filled(1 * 1001, 0.0).reshape([1, 1001]);
    _interpreter.run(input, output);

    // Postprocessing
    return parseOutput(output);
  }
}
```

#### ML Kit Integration:
```dart
// Example: Text Recognition (OCR)
class MLKitOCRService {
  final textRecognizer = TextRecognizer();

  Future<String> recognizeText(InputImage image) async {
    // ML Kit handles model automatically
    final RecognizedText result = await textRecognizer.processImage(image);
    return result.text;
  }

  void dispose() {
    textRecognizer.close();
  }
}
```

### Example Projects

**Project 19: AI Photo App**
```bash
Pre-trained Models:
- MobileNetV3 (TFLite Hub) - Image classification
- YOLO-tiny (TFLite Hub) - Object detection
- ML Kit Face Detection - Face detection
- ML Kit Image Labeling - Auto labeling

Sources:
- https://tfhub.dev/google/lite-model/mobilenet_v3_small_100_224/1
- https://tfhub.dev/neso613/lite-model/yolo-v4-tiny/1
- ML Kit (built-in)

NO TRAINING - Just download and integrate
```

### Quality Criteria
- [ ] Uses only pre-trained models
- [ ] Models from official sources (TFLite Hub, ML Kit)
- [ ] Inference time < 200ms on target devices
- [ ] Proper error handling
- [ ] Model source documented
- [ ] Performance benchmarks included
- [ ] Graceful degradation on errors

### Handoff Protocol
**To:** Tutorial Development Agent, Documentation Agent
**Handoff Package:**
- AI-integrated apps
- Model source documentation
- Integration guides
- Performance benchmarks
- Known limitations

---

## Agent 3: Swift Integration Agent 🍎

### Persona
**Name:** Native Bridge
**Expertise:** Swift, iOS frameworks, Flutter platform channels
**Personality:** Detail-oriented, iOS-focused, bridge-builder
**Years of Experience:** 4+ years iOS development, 2+ years Flutter

### Responsibilities
1. Create platform channels (MethodChannel, EventChannel)
2. Integrate iOS native features (HealthKit, ARKit, Core Location)
3. Write Swift code for native functionality
4. Build Swift integration projects (Projects 22-24)
5. Create Swift-Flutter integration guides
6. Document when to use Swift vs Flutter
7. Provide Swift code examples

### Tools & Technologies
- **Languages:** Swift 5.0+, Dart 3.0+
- **iOS Frameworks:**
  - HealthKit
  - ARKit
  - Core Location
  - Core Data
  - WatchKit
  - WidgetKit
  - AVFoundation
- **Flutter:** Platform channels, MethodChannel, EventChannel
- **Tools:** Xcode, CocoaPods, Swift Package Manager

### Input Requirements
```json
{
  "project_name": "string",
  "native_features": ["list of iOS features"],
  "channel_type": "enum: [method, event, basic_message]",
  "ios_frameworks": ["HealthKit", "ARKit", "etc."],
  "minimum_ios_version": "string (e.g., '13.0')"
}
```

### Output Deliverables

For Each Swift Project:
```
projects/{number}-{swift-project}/
├── lib/
│   └── services/
│       ├── platform_service.dart      # Dart side
│       └── {feature}_channel.dart     # Channel definitions
├── ios/
│   └── Runner/
│       ├── AppDelegate.swift
│       ├── {Feature}Plugin.swift      # Swift plugin
│       ├── {Feature}ViewController.swift
│       └── Podfile (if needed)
├── docs/
│   ├── SWIFT_INTEGRATION.md
│   ├── PLATFORM_CHANNELS.md
│   └── IOS_SETUP.md
└── README.md
```

### Platform Channel Examples

#### MethodChannel Example:
```swift
// Swift side (iOS/Runner/HealthKitPlugin.swift)
import Flutter
import HealthKit

class HealthKitPlugin: NSObject, FlutterPlugin {
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.example.healthkit",
            binaryMessenger: registrar.messenger()
        )
        let instance = HealthKitPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getStepCount":
            getStepCount(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getStepCount(result: @escaping FlutterResult) {
        // HealthKit implementation
        let healthStore = HKHealthStore()
        // ... query steps
        result(steps) // Return to Flutter
    }
}
```

```dart
// Dart side (lib/services/healthkit_service.dart)
class HealthKitService {
  static const platform = MethodChannel('com.example.healthkit');

  Future<int> getStepCount() async {
    try {
      final int steps = await platform.invokeMethod('getStepCount');
      return steps;
    } on PlatformException catch (e) {
      print("Failed to get steps: ${e.message}");
      return 0;
    }
  }
}
```

#### EventChannel Example (Streaming):
```swift
// Swift side - Real-time location updates
class LocationStreamHandler: NSObject, FlutterStreamHandler {
    private var locationManager: CLLocationManager?
    private var eventSink: FlutterEventSink?

    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationManager?.stopUpdatingLocation()
        eventSink = nil
        return nil
    }
}

extension LocationStreamHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                        didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let data = [
                "latitude": location.coordinate.latitude,
                "longitude": location.coordinate.longitude
            ]
            eventSink?(data)
        }
    }
}
```

```dart
// Dart side - Listen to location stream
class LocationService {
  static const eventChannel = EventChannel('com.example.location/stream');

  Stream<Map<String, double>> get locationStream {
    return eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => Map<String, double>.from(event));
  }
}
```

### Example Projects

**Project 22: HealthKit Fitness Tracker**
```bash
Swift Features:
- HealthKit data reading
- Workout tracking
- Background health monitoring
- Watch connectivity

Platform Channels:
- MethodChannel: One-time queries (get steps, heart rate)
- EventChannel: Real-time health updates
- Background tasks: Health monitoring

Complexity: 40-50 hours
Swift Level: Intermediate
```

**Project 23: AR Furniture Viewer**
```bash
Swift Features:
- ARKit scene management
- 3D model placement
- Room scanning
- Camera integration

Platform Channels:
- Complex MethodChannel: AR scene control
- EventChannel: AR session updates
- Image transfer: Screenshots/video

Complexity: 45-55 hours
Swift Level: Advanced
```

### Quality Criteria
- [ ] Platform channels properly implemented
- [ ] Memory management correct (no leaks)
- [ ] iOS permissions correctly requested
- [ ] Works on iOS 13+
- [ ] Graceful error handling
- [ ] Swift code well-commented
- [ ] Integration guide complete
- [ ] Example code provided

### Handoff Protocol
**To:** Tutorial Development Agent, Documentation Agent
**Handoff Package:**
- Swift-integrated projects
- Platform channel examples
- Integration guides
- When to use Swift vs Flutter guide
- iOS setup instructions

---

## Agent 4: Tutorial Development Agent 📖

### Persona
**Name:** Learning Designer
**Expertise:** Technical education, instructional design, Flutter
**Personality:** Patient, clear communicator, learner-focused
**Years of Experience:** 5+ years teaching programming

### Responsibilities
1. Create 170+ step-by-step tutorials
2. Design progressive learning paths
3. Write clear explanations of concepts
4. Create practice challenges
5. Build starter and solution code
6. Test all tutorials
7. Ensure accessibility for diverse learners

### Tools & Technologies
- Markdown for documentation
- Flutter/Dart for code examples
- Mermaid for diagrams
- Code formatters

### Input Requirements
```json
{
  "topic": "string",
  "difficulty": "enum: [beginner, intermediate, advanced, edge-ai, swift]",
  "prerequisites": ["list"],
  "related_project": "string (optional)",
  "estimated_time": "number (minutes)",
  "learning_objectives": ["list"]
}
```

### Output Deliverables

For Each Tutorial:
```
tutorials/{category}/{number}-{topic}/
├── README.md                          # Overview
├── LEARNING_OBJECTIVES.md
├── PREREQUISITES.md
├── STEPS.md                           # Step-by-step guide
├── CODE_EXPLANATION.md
├── CONCEPTS.md
├── starter/
│   ├── lib/
│   ├── test/
│   └── pubspec.yaml
├── solution/
│   ├── lib/
│   ├── test/
│   └── pubspec.yaml
├── CHALLENGES.md                      # Practice exercises
└── COMMON_MISTAKES.md
```

### Tutorial Categories

**Beginner (40 tutorials)**
- Tutorial 001: First Flutter App
- Tutorial 005: Understanding Widgets
- Tutorial 010: Navigation Basics
- Tutorial 015: State Management Intro
- ...

**Intermediate (50 tutorials)**
- Tutorial 050: Provider State Management
- Tutorial 055: Riverpod Basics
- Tutorial 060: BLoC Pattern
- Tutorial 065: Firebase Auth
- ...

**Advanced (40 tutorials)**
- Tutorial 100: Custom Painters
- Tutorial 105: Complex Animations
- Tutorial 110: Clean Architecture
- Tutorial 115: Performance Optimization
- ...

**Edge AI (20 tutorials)**
- Tutorial 200: TFLite Basics
- Tutorial 201: ML Kit Image Labeling
- Tutorial 202: Integrating Pre-trained Models
- Tutorial 203: OCR with ML Kit
- Tutorial 205: Real-time Object Detection
- ...

**Swift Integration (20 tutorials)**
- Tutorial 300: Platform Channels 101
- Tutorial 301: MethodChannel Deep Dive
- Tutorial 302: EventChannel Streaming
- Tutorial 303: Swift Basics for Flutter Devs
- Tutorial 305: HealthKit Integration
- Tutorial 310: ARKit with Flutter
- ...

### Quality Criteria
- [ ] Clear learning objectives
- [ ] Prerequisites listed
- [ ] Step-by-step unambiguous
- [ ] Code examples work
- [ ] Explanations clear
- [ ] Challenges progressive
- [ ] All code tested
- [ ] Both starter and solution provided

### Handoff Protocol
**To:** Documentation Agent
**Handoff Package:**
- All tutorials
- Tutorial index
- Learning path map
- Dependencies list

---

## Agent 5: Documentation Agent 📝

### Persona
**Name:** Doc Master
**Expertise:** Technical writing, documentation, developer experience
**Personality:** Clear, organized, detail-oriented
**Years of Experience:** 6+ years technical writing

### Responsibilities
1. Write API documentation
2. Create architecture diagrams
3. Write setup and deployment guides
4. Create video tutorial scripts (optional)
5. Maintain changelog
6. Final polish on all documentation
7. Create master README updates

### Tools & Technologies
- Markdown, MDX
- Mermaid for diagrams
- DartDoc for API docs

### Input Requirements
```json
{
  "doc_type": "enum: [api, architecture, guide, changelog]",
  "target_audience": "enum: [developers, contributors]",
  "project": "string",
  "scope": "string"
}
```

### Output Deliverables

```
docs/
├── API.md
├── ARCHITECTURE.md
├── SETUP.md
├── DEPLOYMENT.md
├── TROUBLESHOOTING.md
├── CHANGELOG.md
├── diagrams/
│   ├── architecture.mmd
│   ├── data-flow.mmd
│   └── ai-pipeline.mmd
└── swift-flutter-integration/
    ├── platform-channels-guide.md
    ├── when-to-use-swift.md
    └── ios-specific-features.md
```

### Quality Criteria
- [ ] Clear and concise
- [ ] Code examples work
- [ ] Diagrams easy to understand
- [ ] Links verified
- [ ] Grammar correct
- [ ] Versioned

### Handoff Protocol
**Final Agent** - Delivers complete documentation package

---

## 🔄 Agent Collaboration Matrix

| From Agent | To Agent | Deliverable |
|------------|----------|-------------|
| Flutter Dev | Tutorial Dev | App code examples |
| Flutter Dev | Documentation | Architecture docs |
| Edge AI | Tutorial Dev | AI integration examples |
| Edge AI | Documentation | Model integration guides |
| Swift | Tutorial Dev | Platform channel examples |
| Swift | Documentation | Swift-Flutter guides |
| Tutorial Dev | Documentation | Tutorial content |

---

## 🎯 Success Metrics by Agent

### Flutter Development Agent
- 13 traditional apps completed
- 0 critical bugs
- Clean architecture in all projects

### Edge AI Integration Agent
- 3 AI apps completed
- All models from official sources
- Inference < 200ms

### Swift Integration Agent
- 3 Swift projects completed
- Platform channels working
- iOS features integrated

### Tutorial Development Agent
- 170+ tutorials created
- All tutorials tested
- 100% have solutions

### Documentation Agent
- 100% code documented
- All guides complete
- Architecture diagrams clear

---

**Status:** ✅ Ready for Implementation (REVISED)
**Next Document:** AGENT_COMMUNICATION_PROTOCOL.md (no changes needed)
