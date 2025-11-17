import 'package:flutter/material.dart';
import 'counter_screen.dart';
// TODO: Import todo_screen.dart when created

/// Home screen with navigation to Counter and Todo features
///
/// This demonstrates:
/// - StatelessWidget (screen doesn't need to change)
/// - Navigation with Navigator.push()
/// - Material Design Card widgets
/// - Column layout
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Projects'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome text
              const Text(
                'Choose a Feature',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Counter button - FULLY IMPLEMENTED
              _buildFeatureCard(
                context: context,
                title: 'Counter',
                description: 'A fully implemented counter as a reference',
                icon: Icons.add_circle_outline,
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CounterScreen(),
                    ),
                  );
                },
                status: 'COMPLETE ✓',
                statusColor: Colors.green,
              ),

              const SizedBox(height: 20),

              // Todo button - TO BE IMPLEMENTED
              _buildFeatureCard(
                context: context,
                title: 'Todo List',
                description: 'Your task: Build a todo list app',
                icon: Icons.check_box_outlined,
                color: Colors.orange,
                onTap: () {
                  // TODO: Navigate to TodoScreen when implemented
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const TodoScreen(),
                  //   ),
                  // );

                  // Temporary: Show not implemented dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Not Implemented'),
                      content: const Text(
                        'This feature is for you to implement!\n\n'
                        'Check ROADMAP.md for instructions.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                status: 'TODO',
                statusColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to build feature cards
  ///
  /// This demonstrates:
  /// - Widget composition
  /// - Reusable widget patterns
  /// - Named parameters
  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required String status,
    required Color statusColor,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with status badge
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
