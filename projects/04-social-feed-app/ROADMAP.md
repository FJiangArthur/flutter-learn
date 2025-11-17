# Project 4: Social Media Feed - Roadmap

## 🎯 Overview
**Difficulty:** Advanced
**Time:** 12-15 hours
**Focus:** Advanced UI, Animations, Custom Painters, Performance

---

## 🎓 Learning Objectives

- CustomScrollView and Slivers
- Hero animations
- Custom painters and shapes
- Image loading and caching
- Infinite scroll with pagination
- Gesture detection
- Performance optimization

---

## 🔨 Your Tasks

### **Task 1: Build Feed with Slivers**

```dart
CustomScrollView(
  slivers: [
    SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(/* profile header */),
    ),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => PostCard(post: posts[index]),
        childCount: posts.length,
      ),
    ),
  ],
)
```

**Features:**
- [ ] Collapsing header with profile info
- [ ] Infinite scroll loading more posts
- [ ] Pull-to-refresh
- [ ] Smooth scrolling performance

---

### **Task 2: Implement Animations**

**Hero Animation:**
```dart
// In feed
Hero(
  tag: 'post-${post.id}',
  child: Image.network(post.imageUrl),
)

// In detail screen
Hero(
  tag: 'post-${post.id}',
  child: Image.network(post.imageUrl),
)
```

**Implicit Animations:**
```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  color: isLiked ? Colors.red : Colors.grey,
)
```

**Explicit Animations:**
```dart
class _HeartAnimationState extends State with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
  }

  void _onLike() {
    _controller.forward().then((_) => _controller.reverse());
  }
}
```

---

### **Task 3: Custom Painter**

**Create Custom Progress Indicator:**
```dart
class CircularProgress extends CustomPainter {
  final double progress;

  CircularProgress(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: Draw custom progress ring
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularProgress old) => old.progress != progress;
}

// Usage
CustomPaint(
  painter: CircularProgress(0.7),
  child: Container(width: 100, height: 100),
)
```

---

### **Task 4: Image Handling**

```dart
// Use cached_network_image
CachedNetworkImage(
  imageUrl: post.imageUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  fadeInDuration: Duration(milliseconds: 300),
)
```

---

### **Task 5: Gestures**

```dart
// Swipe to like
Dismissible(
  key: Key(post.id),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) => _deletePost(post.id),
  background: Container(color: Colors.red),
  child: PostCard(post: post),
)

// Pinch to zoom image
InteractiveViewer(
  child: Image.network(url),
)

// Double tap to like
GestureDetector(
  onDoubleTap: () => _likePost(),
  child: PostImage(),
)
```

---

### **Task 6: Infinite Scroll**

```dart
class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = [];
  int _page = 1;
  bool _isLoading = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPosts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final newPosts = await api.fetchPosts(page: ++_page);

    setState(() {
      posts.addAll(newPosts);
      _isLoading = false;
    });
  }
}
```

---

### **Task 7: Performance Optimization**

**Use const widgets:**
```dart
const Icon(Icons.favorite)  // Reused across rebuilds
```

**Add RepaintBoundary:**
```dart
RepaintBoundary(
  child: ExpensiveWidget(),
)
```

**Use ListView.builder:**
```dart
// ✅ Good - only builds visible items
ListView.builder(itemBuilder: ...)

// ❌ Bad - builds all items upfront
ListView(children: posts.map(...).toList())
```

**Profile with DevTools:**
- Check for jank (frames > 16ms)
- Use Timeline view
- Check widget rebuilds
- Monitor memory usage

---

## 📖 Advanced Concepts

### **Sliver Widgets**
- `SliverAppBar` - Collapsing app bar
- `SliverList` - Scrollable list
- `SliverGrid` - Scrollable grid
- `SliverToBoxAdapter` - Single box in sliver
- `SliverFillRemaining` - Fills remaining space

### **Animation Controllers**
- `AnimationController` - Controls animation
- `Tween` - Defines range (0.0 to 1.0, etc.)
- `CurvedAnimation` - Non-linear animations
- `AnimatedBuilder` - Rebuilds on animation changes

---

## ✅ Completion Criteria

- [ ] Smooth scrolling with slivers
- [ ] Collapsing header works
- [ ] Hero animation between screens
- [ ] Like button animates
- [ ] Custom progress indicator
- [ ] Images load and cache efficiently
- [ ] Infinite scroll loads more posts
- [ ] Double tap to like works
- [ ] Swipe gestures work
- [ ] No jank (60 FPS)

---

**Next:** [Project 5: Chat App](../05-chat-app/ROADMAP.md)
