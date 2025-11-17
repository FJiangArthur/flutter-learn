import 'package:flutter/material.dart';

/// Counter Screen - FULLY IMPLEMENTED REFERENCE
///
/// Study this implementation to learn:
/// - StatefulWidget vs StatelessWidget
/// - setState() mechanism
/// - Widget lifecycle
/// - Event handling (button presses)
/// - AppBar with actions
/// - FloatingActionButton
/// - Layout with Column and Center
/// - Text styling
///
/// This serves as your reference for building the Todo app!
class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

/// State class holds mutable state for CounterScreen
///
/// This is where we:
/// - Declare state variables
/// - Implement lifecycle methods
/// - Define setState() calls
/// - Build the UI
class _CounterScreenState extends State<CounterScreen> {
  // ═══════════════════════════════════════════════════════════
  // STATE VARIABLES
  // ═══════════════════════════════════════════════════════════

  /// The counter value - this is our mutable state
  ///
  /// This is the core state that changes over time.
  /// Every time we call setState(), this value can change,
  /// and the UI will rebuild to reflect the new value.
  int _counter = 0;

  /// Tracks whether counter can go negative
  ///
  /// This demonstrates how you can have multiple pieces of state
  /// and how they interact with each other.
  bool _allowNegative = true;

  // ═══════════════════════════════════════════════════════════
  // LIFECYCLE METHODS
  // ═══════════════════════════════════════════════════════════

  @override
  void initState() {
    super.initState();
    // Called once when widget is first created
    // This is where you'd:
    // - Initialize state variables
    // - Start timers/animations
    // - Load initial data
    // - Subscribe to streams

    print('CounterScreen: initState() called');
  }

  @override
  void dispose() {
    // Called once when widget is removed permanently
    // This is where you'd:
    // - Cancel timers
    // - Close streams
    // - Dispose controllers
    // - Clean up resources

    print('CounterScreen: dispose() called');
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════
  // STATE MODIFICATION METHODS
  // ═══════════════════════════════════════════════════════════

  /// Increments the counter
  ///
  /// Note: We wrap state changes in setState()
  /// This tells Flutter that state changed and UI needs to rebuild
  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Show a snackbar as feedback
    _showSnackBar('Counter incremented to $_counter');
  }

  /// Decrements the counter
  ///
  /// Demonstrates conditional logic in state updates
  void _decrementCounter() {
    setState(() {
      // Only decrement if we allow negatives OR counter is positive
      if (_allowNegative || _counter > 0) {
        _counter--;
      }
    });

    _showSnackBar('Counter decremented to $_counter');
  }

  /// Resets counter to zero
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });

    _showSnackBar('Counter reset to 0');
  }

  /// Toggles whether negative numbers are allowed
  void _toggleNegativeAllowed() {
    setState(() {
      _allowNegative = !_allowNegative;

      // If we just disabled negatives and counter is negative, reset to 0
      if (!_allowNegative && _counter < 0) {
        _counter = 0;
      }
    });
  }

  /// Helper method to show snackbar feedback
  ///
  /// This isn't part of state management, but demonstrates
  /// how to use BuildContext to show UI feedback
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  // BUILD METHOD - DEFINES THE UI
  // ═══════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    // build() is called:
    // - After initState()
    // - Every time setState() is called
    // - When parent widget rebuilds
    // - When dependencies (like Theme) change

    print('CounterScreen: build() called');

    return Scaffold(
      // ───────────────────────────────────────────────────────
      // APP BAR
      // ───────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text('Counter (Reference)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Reset button in app bar
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset counter',
            onPressed: _resetCounter,
          ),
        ],
      ),

      // ───────────────────────────────────────────────────────
      // BODY
      // ───────────────────────────────────────────────────────
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Instruction text
              const Text(
                'Study this implementation!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This shows you all the patterns you\'ll use for the Todo app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              // Counter display
              const Text(
                'You have pushed the button this many times:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // The counter value - THIS IS THE KEY!
              // This Text widget rebuilds every time setState() is called
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _counter < 0
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                    ),
              ),

              const SizedBox(height: 40),

              // Increment/Decrement buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decrement button
                  ElevatedButton.icon(
                    onPressed: _decrementCounter,
                    icon: const Icon(Icons.remove),
                    label: const Text('Decrement'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.red[900],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Increment button
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    icon: const Icon(Icons.add),
                    label: const Text('Increment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      foregroundColor: Colors.green[900],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Allow negative toggle
              Card(
                child: SwitchListTile(
                  title: const Text('Allow Negative Numbers'),
                  subtitle: Text(
                    _allowNegative
                        ? 'Counter can go below zero'
                        : 'Counter stops at zero',
                  ),
                  value: _allowNegative,
                  onChanged: (value) => _toggleNegativeAllowed(),
                ),
              ),

              const SizedBox(height: 40),

              // Learning tips
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          'Learning Points',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildLearningPoint('setState() updates the UI'),
                    _buildLearningPoint('State variables are mutable'),
                    _buildLearningPoint('build() is called on each update'),
                    _buildLearningPoint('Event handlers modify state'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ───────────────────────────────────────────────────────
      // FLOATING ACTION BUTTON
      // ───────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Helper to build learning point rows
  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.green[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
