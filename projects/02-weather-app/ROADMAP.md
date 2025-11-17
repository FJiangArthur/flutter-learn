# Project 2: Weather App - Roadmap

## 🎯 Project Overview

**Difficulty:** Intermediate
**Estimated Time:** 6-8 hours
**Focus:** HTTP requests, async/await, JSON parsing, error handling, API integration

---

## 📚 Learning Objectives

- HTTP requests with dio or http package
- Async/await patterns
- JSON parsing and serialization
- FutureBuilder widget
- Error handling and retry logic
- Loading and empty states
- City search and favorites
- Platform-specific UI (Material vs Cupertino)

---

## ✅ What's Already Implemented

### **1. Basic Structure**
- ✅ App entry point and theme
- ✅ Home screen with city input
- ✅ API service class structure
- ✅ Weather model with partial implementation

### **2. Reference Implementation**
- ✅ Simple HTTP example screen
- ✅ FutureBuilder example
- ✅ Error handling pattern

---

## 🔨 Your Tasks

### **Task 1: Complete Weather Model** (`lib/models/weather.dart`)

```dart
class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  // TODO: Add fromJson factory
  // TODO: Add toJson method
}
```

**API Response Example:**
```json
{
  "name": "London",
  "main": {
    "temp": 15.5,
    "feels_like": 14.2,
    "humidity": 72
  },
  "weather": [
    {
      "description": "cloudy",
      "icon": "04d"
    }
  ],
  "wind": {
    "speed": 5.2
  }
}
```

---

### **Task 2: Implement API Service** (`lib/services/weather_api.dart`)

**Get API Key:**
1. Sign up at [OpenWeatherMap](https://openweathermap.org/api)
2. Get free API key
3. Never commit API keys! Use environment variables or constants file

**Methods to Implement:**
```dart
class WeatherApi {
  static const String _apiKey = 'YOUR_API_KEY_HERE';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  // TODO: Implement getCurrentWeather(String cityName)
  // TODO: Implement getForecast(String cityName)
  // TODO: Implement searchCities(String query)
  // TODO: Add error handling
  // TODO: Add timeout handling
}
```

---

### **Task 3: Build Weather Display Screen** (`lib/screens/weather_screen.dart`)

**Features:**
- [ ] City name input field
- [ ] Search button
- [ ] FutureBuilder for async data
- [ ] Loading indicator
- [ ] Weather card with:
  - [ ] City name
  - [ ] Temperature (large)
  - [ ] Feels like temperature
  - [ ] Weather description
  - [ ] Weather icon
  - [ ] Humidity and wind speed
- [ ] Error state handling
- [ ] Empty state when no search

---

### **Task 4: Add 5-Day Forecast** (`lib/screens/forecast_screen.dart`)

**API Endpoint:** `/forecast?q={city}&appid={key}&units=metric`

**Features:**
- [ ] Call forecast API
- [ ] Parse list of forecast items
- [ ] Group by day
- [ ] Display as horizontal ListView
- [ ] Show date, temp, icon for each day

---

### **Task 5: Implement City Search**

**Features:**
- [ ] Search bar with autocomplete
- [ ] Recent searches (stored locally)
- [ ] Favorite cities
- [ ] Save favorites with shared_preferences
- [ ] Quick access to favorite cities

---

### **Task 6: Add Pull-to-Refresh**

```dart
RefreshIndicator(
  onRefresh: _refreshWeather,
  child: ListView(/* weather content */),
)
```

---

### **Task 7: Platform-Specific UI**

**Learn to use:**
```dart
import 'dart:io';

Widget build(BuildContext context) {
  if (Platform.isIOS) {
    return CupertinoPageScaffold(/* iOS style */);
  } else {
    return Scaffold(/* Android style */);
  }
}
```

**Or use adaptive widgets:**
```dart
Platform.isIOS ? CupertinoButton() : ElevatedButton()
```

---

## 📖 Key Concepts

### **1. HTTP Requests with Dio**

```dart
import 'package:dio/dio.dart';

final dio = Dio();

Future<Weather> fetchWeather(String city) async {
  try {
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'q': city,
        'appid': apiKey,
        'units': 'metric',
      },
      options: Options(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather');
    }
  } on DioException catch (e) {
    throw _handleDioError(e);
  }
}
```

### **2. FutureBuilder Pattern**

```dart
class WeatherScreen extends StatefulWidget {
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Weather>? _weatherFuture;

  void _searchWeather(String city) {
    setState(() {
      _weatherFuture = WeatherApi().getCurrentWeather(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: _weatherFuture,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        // Error
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // No data yet
        if (!snapshot.hasData) {
          return Text('Search for a city');
        }

        // Success - show data
        final weather = snapshot.data!;
        return WeatherCard(weather: weather);
      },
    );
  }
}
```

### **3. Error Handling**

```dart
Future<Weather> fetchWeather(String city) async {
  try {
    final response = await dio.get(/*...*/);
    return Weather.fromJson(response.data);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw 'Connection timeout - check your internet';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      throw 'Server took too long to respond';
    } else if (e.response?.statusCode == 404) {
      throw 'City not found';
    } else if (e.response?.statusCode == 401) {
      throw 'Invalid API key';
    } else {
      throw 'Network error: ${e.message}';
    }
  } catch (e) {
    throw 'Unexpected error: $e';
  }
}
```

### **4. JSON Parsing**

```dart
import 'dart:convert';

class Weather {
  final String cityName;
  final double temperature;

  Weather({required this.cityName, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] as String,
      // Handle nested objects
      temperature: (json['main']['temp'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {'temp': temperature},
    };
  }
}

// Usage:
final weatherJson = jsonDecode(responseBody);
final weather = Weather.fromJson(weatherJson);
```

---

## 🧪 Testing

**Manual Tests:**
- [ ] Search for valid city shows weather
- [ ] Search for invalid city shows error
- [ ] Offline shows appropriate error
- [ ] Loading indicator appears during fetch
- [ ] Temperature units are correct (Celsius/Fahrenheit)
- [ ] Forecast shows 5 days
- [ ] Pull-to-refresh updates data
- [ ] Favorites persist after app restart

**Edge Cases:**
- [ ] Empty search query
- [ ] Very long city names
- [ ] Special characters in city name
- [ ] API timeout
- [ ] Network disconnected

---

## 📚 Resources

- [OpenWeatherMap API Docs](https://openweathermap.org/current)
- [Dio Package](https://pub.dev/packages/dio)
- [FutureBuilder Class](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html)
- [Async Programming in Dart](https://dart.dev/codelabs/async-await)

---

## ✅ Completion Criteria

- [ ] Can fetch and display current weather
- [ ] Can view 5-day forecast
- [ ] Error handling works for all cases
- [ ] Loading states look good
- [ ] Can save and access favorite cities
- [ ] Pull-to-refresh works
- [ ] Platform-specific UI implemented
- [ ] Can explain async/await pattern
- [ ] Can explain FutureBuilder lifecycle
- [ ] Can rebuild from scratch

---

**Next:** [Project 3: Shopping App](../03-shopping-app/ROADMAP.md)
