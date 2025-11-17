# Project 7: Media Player App - Roadmap

## 🎯 Overview
**Difficulty:** Advanced
**Time:** 12-15 hours
**Focus:** Audio/Video, Camera, File System, iOS Media Handling

---

## 🎓 Learning Objectives

- Audio playback (foreground & background)
- Video player with controls
- Camera integration
- File system operations
- iOS audio session handling
- Picture-in-Picture (iOS)
- Media notifications

---

## 🔨 Your Tasks

### **Task 1: Audio Player**

**Setup:**
```yaml
dependencies:
  just_audio: ^0.9.36
  audio_service: ^0.18.12  # For background audio
```

**Basic Player:**
```dart
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    try {
      // Load from network
      await player.setUrl('https://example.com/song.mp3');

      // Or load from asset
      // await player.setAsset('assets/song.mp3');

      // Or load from file
      // await player.setFilePath('/path/to/file.mp3');

    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Play/Pause button
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final playing = playerState?.playing ?? false;

            return IconButton(
              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (playing) {
                  player.pause();
                } else {
                  player.play();
                }
              },
            );
          },
        ),

        // Progress bar
        StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final duration = player.duration ?? Duration.zero;

            return Slider(
              value: position.inMilliseconds.toDouble(),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                player.seek(Duration(milliseconds: value.toInt()));
              },
            );
          },
        ),

        // Time display
        StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final duration = player.duration ?? Duration.zero;

            return Text(
              '${_formatDuration(position)} / ${_formatDuration(duration)}',
            );
          },
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }
}
```

---

### **Task 2: Background Audio (iOS)**

**iOS Configuration (Info.plist):**
```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>
```

**Using audio_service:**
```dart
import 'package:audio_service/audio_service.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler() {
    // Listen to player state changes
    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        playing: _player.playing,
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
      ));
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();
}

// Initialize
final audioHandler = await AudioService.init(
  builder: () => AudioPlayerHandler(),
  config: AudioServiceConfig(
    androidNotificationChannelName: 'Music Player',
    androidNotificationIcon: 'mipmap/ic_launcher',
  ),
);
```

---

### **Task 3: Video Player**

**Setup:**
```yaml
dependencies:
  video_player: ^2.8.1
  chewie: ^1.7.4  # Better controls
```

**Implementation:**
```dart
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({required this.videoUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _videoController = VideoPlayerController.network(widget.videoUrl);
    await _videoController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController.value.aspectRatio,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      placeholder: Center(child: CircularProgressIndicator()),
      errorBuilder: (context, errorMessage) {
        return Center(child: Text('Error: $errorMessage'));
      },
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: _chewieController != null
          ? Chewie(controller: _chewieController!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
```

---

### **Task 4: Camera Integration**

**Setup:**
```yaml
dependencies:
  camera: ^0.10.5
  image_picker: ^1.0.5
```

**iOS Configuration (Info.plist):**
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access for photos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need photo library access</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for videos</string>
```

**Camera Implementation:**
```dart
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(
      _cameras![0],  // Back camera
      ResolutionPreset.high,
    );

    await _controller!.initialize();
    setState(() {});
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    final XFile image = await _controller!.takePicture();
    print('Picture saved to: ${image.path}');

    // Navigate to preview or save
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        CameraPreview(_controller!),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: FloatingActionButton(
              onPressed: _takePicture,
              child: Icon(Icons.camera),
            ),
          ),
        ),
      ],
    );
  }
}
```

**Image Picker (Simpler Alternative):**
```dart
import 'package:image_picker/image_picker.dart';

final picker = ImagePicker();

// Pick from gallery
final XFile? image = await picker.pickImage(source: ImageSource.gallery);

// Take photo with camera
final XFile? photo = await picker.pickImage(source: ImageSource.camera);

// Pick video
final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
```

---

### **Task 5: File System Operations**

```dart
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Get directories
final appDir = await getApplicationDocumentsDirectory();
final tempDir = await getTemporaryDirectory();

// Save file
Future<File> saveFile(String filename, List<int> bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename');
  return await file.writeAsBytes(bytes);
}

// Read file
Future<String> readFile(String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename');
  return await file.readAsString();
}

// List files
Future<List<FileSystemEntity>> listFiles() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.listSync();
}

// Delete file
Future<void> deleteFile(String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename');
  if (await file.exists()) {
    await file.delete();
  }
}
```

---

### **Task 6: iOS-Specific Features**

**Picture-in-Picture:**
```dart
// In ChewieController
ChewieController(
  // ...
  allowPlaybackSpeedChanging: true,
  // iOS-specific
  iosEnablePIP: true,  // Picture-in-Picture
)
```

**Audio Session (iOS):**
```swift
// In AppDelegate.swift
import AVFoundation

override func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
  let session = AVAudioSession.sharedInstance()
  try? session.setCategory(.playback, mode: .default)
  try? session.setActive(true)

  return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
```

---

## ✅ Completion Criteria

- [ ] Audio plays from network and local
- [ ] Play/pause controls work
- [ ] Progress bar and seeking work
- [ ] Background audio works on iOS
- [ ] Video player displays correctly
- [ ] Video controls (play, pause, seek, fullscreen)
- [ ] Camera preview shows
- [ ] Can take photos and videos
- [ ] Files save to device
- [ ] Can list and delete files
- [ ] Picture-in-Picture works on iOS

---

**Next:** [Project 8: E-Commerce MVP](../08-ecommerce-mvp/ROADMAP.md)
