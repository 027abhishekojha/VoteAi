import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  index == 0 ? Icons.how_to_vote : Icons.notification_important,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                index == 0
                    ? 'New Election Available'
                    : 'Complete Identity Verification',
              ),
              subtitle: Text(
                index == 0
                    ? 'Mumbai Municipal Elections 2025 is now open for voting'
                    : 'Verify your identity to participate in upcoming elections',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  index == 0 ? '/available-elections' : '/verify',
                );
              },
            ),
          );
        },
      ),
    );
  }
}