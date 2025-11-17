# Project 6: Maps & Location App - Roadmap

## 🎯 Overview
**Difficulty:** Advanced
**Time:** 10-12 hours
**Focus:** Platform Channels, Native Integration, Google Maps, GPS

---

## 🎓 Learning Objectives

- Google Maps integration
- Location services (GPS)
- Platform-specific permissions
- Method channels (Flutter ↔ Native)
- Custom map markers
- Geofencing
- Directions and routes

---

## 🔨 Your Tasks

### **Task 1: Setup Google Maps**

**1. Get API Key:**
- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Enable Maps SDK for Android and iOS
- Create API key

**2. Configure iOS (Info.plist):**
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby places</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>We need your location for tracking</string>
```

**3. Add Package:**
```yaml
dependencies:
  google_maps_flutter: ^2.5.0
  geolocator: ^10.1.0
```

---

### **Task 2: Display Map**

```dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: (controller) {
        _controller = controller;
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
```

---

### **Task 3: Get User Location**

```dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Request permission
  Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  // Get current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Track location continuously
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    );
  }
}
```

---

### **Task 4: Add Custom Markers**

```dart
class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = {};

  void _addMarker(LatLng position, String id, String title) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          infoWindow: InfoWindow(
            title: title,
            snippet: 'Tap for details',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          onTap: () {
            print('Marker tapped: $title');
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialPosition,
      markers: _markers,
      onMapCreated: (controller) {
        _controller = controller;
        _addMarker(
          LatLng(37.7749, -122.4194),
          'marker1',
          'San Francisco',
        );
      },
    );
  }
}
```

**Custom Marker Icons:**
```dart
BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
  ImageConfiguration(size: Size(48, 48)),
  'assets/custom_marker.png',
);
```

---

### **Task 5: Draw Routes (Polylines)**

```dart
Set<Polyline> _polylines = {};

void _drawRoute(List<LatLng> points) {
  setState(() {
    _polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: points,
        color: Colors.blue,
        width: 5,
        patterns: [PatternItem.dash(30), PatternItem.gap(10)],
      ),
    );
  });
}

// Example: Draw line from A to B
_drawRoute([
  LatLng(37.7749, -122.4194),
  LatLng(37.7849, -122.4094),
]);
```

---

### **Task 6: Platform Channels (Advanced)**

**Use case:** Access iOS-specific location features

**Flutter Side (Dart):**
```dart
import 'package:flutter/services.dart';

class NativeLocation {
  static const platform = MethodChannel('com.example.app/location');

  Future<String> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return 'Battery level: $result%';
    } on PlatformException catch (e) {
      return "Failed: '${e.message}'.";
    }
  }

  Future<void> startLocationTracking() async {
    await platform.invokeMethod('startTracking');
  }
}
```

**iOS Side (Swift):**
```swift
// In AppDelegate.swift
import Flutter
import UIKit
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.example.app/location",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "getBatteryLevel" {
        result(self?.getBatteryLevel())
      } else if call.method == "startTracking" {
        self?.startLocationTracking()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getBatteryLevel() -> Int {
    UIDevice.current.isBatteryMonitoringEnabled = true
    return Int(UIDevice.current.batteryLevel * 100)
  }

  private func startLocationTracking() {
    // Implement iOS-specific location tracking
  }
}
```

---

### **Task 7: Additional Features**

**Search Places:**
```dart
// Use google_places_flutter or places_autocomplete packages
```

**Calculate Distance:**
```dart
double distanceInMeters = Geolocator.distanceBetween(
  lat1, lon1,
  lat2, lon2,
);
```

**Geofencing:**
```dart
double distance = Geolocator.distanceBetween(
  currentLat, currentLon,
  targetLat, targetLon,
);

if (distance < 100) {  // Within 100 meters
  print('Entered geofence!');
}
```

---

## ✅ Completion Criteria

- [ ] Map displays correctly
- [ ] Current location shown
- [ ] Location permission handled
- [ ] Custom markers work
- [ ] Routes drawn with polylines
- [ ] Distance calculation works
- [ ] Platform channel implemented
- [ ] iOS-specific features work
- [ ] Location tracking continuous

---

**Next:** [Project 7: Media Player App](../07-media-player-app/ROADMAP.md)
