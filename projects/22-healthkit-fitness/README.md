# Project 22: HealthKit Fitness Tracker

**Created by:** Agent 6 (Swift Integration Specialist)
**Category:** Swift-Flutter Integration
**Difficulty:** Advanced
**Estimated Time:** 15-20 hours

---

## 🎯 Project Overview

A comprehensive fitness tracking app that integrates iOS HealthKit with Flutter using **platform channels**. Demonstrates seamless Swift-Flutter communication for accessing native iOS features.

### Key Features

**HealthKit Integration (iOS):**
- 📊 Read health data (steps, distance, calories, heart rate)
- 💾 Write workout data to HealthKit
- 📈 Historical data queries
- 🔔 Real-time health updates
- 🏃 Activity ring visualization
- 💤 Sleep tracking
- 🏋️ Workout sessions

**Cross-Platform Features:**
- 📱 Dashboard with health metrics
- 📊 Charts and trends
- 🎯 Daily goals and achievements
- 🏆 Progress tracking
- ⚙️ Settings and preferences

**Android Alternative:**
- Google Fit integration (using health package)

---

## 🏗️ Architecture

```
lib/
├── core/
│   ├── platform/
│   │   ├── method_channel_manager.dart
│   │   ├── healthkit_service.dart
│   │   └── platform_detector.dart
│   └── utils/
├── features/
│   ├── dashboard/
│   ├── workouts/
│   ├── health_data/
│   └── settings/
├── ios/
│   ├── Runner/
│   │   ├── HealthKitManager.swift  ← Swift integration
│   │   ├── AppDelegate.swift
│   │   └── Info.plist
└── main.dart
```

---

## 📦 Dependencies

```yaml
dependencies:
  # Core
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5

  # Charts
  fl_chart: ^0.66.0
  syncfusion_flutter_charts: ^24.1.41

  # Cross-platform Health (fallback for Android)
  health: ^10.1.0

  # Utils
  intl: ^0.19.0
  get_it: ^7.6.4
  dartz: ^0.10.1
  permission_handler: ^11.1.0
```

---

## 🔌 Platform Channels Setup

### 1. Flutter Side (Dart)

```dart
// lib/core/platform/healthkit_service.dart
import 'package:flutter/services.dart';

class HealthKitService {
  static const _channel = MethodChannel('com.example.healthkit');

  // Request authorization
  Future<bool> requestAuthorization() async {
    try {
      final result = await _channel.invokeMethod('requestAuthorization');
      return result as bool;
    } catch (e) {
      print('Error requesting authorization: $e');
      return false;
    }
  }

  // Get today's steps
  Future<int> getTodaySteps() async {
    try {
      final result = await _channel.invokeMethod('getTodaySteps');
      return result as int;
    } catch (e) {
      print('Error getting steps: $e');
      return 0;
    }
  }

  // Get heart rate data
  Future<List<HeartRateSample>> getHeartRate() async {
    try {
      final result = await _channel.invokeMethod('getHeartRate');
      final List<dynamic> data = result as List<dynamic>;
      return data.map((e) => HeartRateSample.fromJson(e)).toList();
    } catch (e) {
      print('Error getting heart rate: $e');
      return [];
    }
  }

  // Write workout
  Future<bool> writeWorkout({
    required String activityType,
    required DateTime startDate,
    required DateTime endDate,
    required double calories,
  }) async {
    try {
      final result = await _channel.invokeMethod('writeWorkout', {
        'activityType': activityType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'calories': calories,
      });
      return result as bool;
    } catch (e) {
      print('Error writing workout: $e');
      return false;
    }
  }
}
```

### 2. iOS Side (Swift)

```swift
// ios/Runner/HealthKitManager.swift
import Foundation
import HealthKit

class HealthKitManager {
    private let healthStore = HKHealthStore()

    // Types to read
    private let typesToRead: Set<HKObjectType> = [
        HKQuantityType.quantityType(forIdentifier: .stepCount)!,
        HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.workoutType()
    ]

    // Types to write
    private let typesToWrite: Set<HKSampleType> = [
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.workoutType()
    ]

    // Request authorization
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, NSError(domain: "HealthKit", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "HealthKit is not available"
            ]))
            return
        }

        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { success, error in
            completion(success, error)
        }
    }

    // Get today's steps
    func getTodaySteps(completion: @escaping (Int, Error?) -> Void) {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0, nil)
            return
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0, error)
                return
            }

            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            completion(steps, nil)
        }

        healthStore.execute(query)
    }

    // Get heart rate data
    func getHeartRate(completion: @escaping ([[String: Any]], Error?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            completion([], nil)
            return
        }

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 100, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let samples = samples as? [HKQuantitySample] else {
                completion([], error)
                return
            }

            let data = samples.map { sample -> [String: Any] in
                let bpm = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
                return [
                    "value": Int(bpm),
                    "date": ISO8601DateFormatter().string(from: sample.startDate)
                ]
            }

            completion(data, nil)
        }

        healthStore.execute(query)
    }

    // Write workout
    func writeWorkout(activityType: String, startDate: Date, endDate: Date, calories: Double, completion: @escaping (Bool, Error?) -> Void) {
        let activityTypeEnum = mapActivityType(activityType)

        let workout = HKWorkout(
            activityType: activityTypeEnum,
            start: startDate,
            end: endDate,
            duration: endDate.timeIntervalSince(startDate),
            totalEnergyBurned: HKQuantity(unit: .kilocalorie(), doubleValue: calories),
            totalDistance: nil,
            metadata: nil
        )

        healthStore.save(workout) { success, error in
            completion(success, error)
        }
    }

    private func mapActivityType(_ type: String) -> HKWorkoutActivityType {
        switch type.lowercased() {
        case "running": return .running
        case "walking": return .walking
        case "cycling": return .cycling
        case "swimming": return .swimming
        default: return .other
        }
    }
}
```

### 3. AppDelegate Integration

```swift
// ios/Runner/AppDelegate.swift
import UIKit
import Flutter
import HealthKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let healthKitManager = HealthKitManager()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let healthKitChannel = FlutterMethodChannel(
            name: "com.example.healthkit",
            binaryMessenger: controller.binaryMessenger
        )

        healthKitChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else { return }

            switch call.method {
            case "requestAuthorization":
                self.healthKitManager.requestAuthorization { success, error in
                    if let error = error {
                        result(FlutterError(code: "HEALTHKIT_ERROR", message: error.localizedDescription, details: nil))
                    } else {
                        result(success)
                    }
                }

            case "getTodaySteps":
                self.healthKitManager.getTodaySteps { steps, error in
                    if let error = error {
                        result(FlutterError(code: "HEALTHKIT_ERROR", message: error.localizedDescription, details: nil))
                    } else {
                        result(steps)
                    }
                }

            case "getHeartRate":
                self.healthKitManager.getHeartRate { data, error in
                    if let error = error {
                        result(FlutterError(code: "HEALTHKIT_ERROR", message: error.localizedDescription, details: nil))
                    } else {
                        result(data)
                    }
                }

            case "writeWorkout":
                guard let args = call.arguments as? [String: Any],
                      let activityType = args["activityType"] as? String,
                      let startDateString = args["startDate"] as? String,
                      let endDateString = args["endDate"] as? String,
                      let calories = args["calories"] as? Double else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                    return
                }

                let formatter = ISO8601DateFormatter()
                guard let startDate = formatter.date(from: startDateString),
                      let endDate = formatter.date(from: endDateString) else {
                    result(FlutterError(code: "INVALID_DATE", message: "Invalid date format", details: nil))
                    return
                }

                self.healthKitManager.writeWorkout(activityType: activityType, startDate: startDate, endDate: endDate, calories: calories) { success, error in
                    if let error = error {
                        result(FlutterError(code: "HEALTHKIT_ERROR", message: error.localizedDescription, details: nil))
                    } else {
                        result(success)
                    }
                }

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```

### 4. Info.plist Configuration

```xml
<!-- ios/Runner/Info.plist -->
<key>NSHealthShareUsageDescription</key>
<string>We need access to your health data to show your fitness progress</string>
<key>NSHealthUpdateUsageDescription</key>
<string>We need permission to save workout data to HealthKit</string>
```

---

## 📚 Learning Objectives

1. **Platform Channels**
   - MethodChannel communication
   - Passing data between Dart and Swift
   - Error handling across platforms
   - Async operations

2. **Swift Integration**
   - Writing Swift code in Flutter projects
   - iOS native APIs
   - HealthKit framework
   - Swift-Flutter interop

3. **HealthKit**
   - Authorization and permissions
   - Reading health data
   - Writing workouts
   - Queries and predicates

4. **Cross-Platform Development**
   - Platform-specific code
   - Fallback implementations
   - Feature detection
   - Platform abstraction

---

## 🎯 Implementation Roadmap

### Week 1-2: Platform Channels
- [ ] Set up MethodChannel
- [ ] Implement Swift HealthKitManager
- [ ] Test authorization flow
- [ ] Read basic health data

### Week 3: Data Integration
- [ ] Fetch steps, distance, calories
- [ ] Implement heart rate tracking
- [ ] Create data models
- [ ] Build repository layer

### Week 4: UI Development
- [ ] Dashboard with health metrics
- [ ] Charts and visualizations
- [ ] Activity rings
- [ ] Settings screen

### Week 5: Advanced Features
- [ ] Write workouts
- [ ] Historical data queries
- [ ] Real-time updates
- [ ] Android fallback (Google Fit)

---

## 📖 Related Tutorials

- Tutorial 300: Introduction to Platform Channels
- Tutorial 301: Swift-Flutter Communication
- Tutorial 305: iOS Native Features
- Tutorial 310: HealthKit Integration

---

**Status:** 🚧 In Development (Agent 6)
**Last Updated:** 2025-11-19
