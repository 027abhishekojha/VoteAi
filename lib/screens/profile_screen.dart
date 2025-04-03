import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildProfileOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person_outline, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Mumbai, Maharashtra',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final options = [
      {
        'icon': Icons.verified_user_outlined,
        'title': 'Identity Verification',
        'subtitle': 'Manage your verification status',
        'route': '/verify',
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Voting Region',
        'subtitle': 'Update your voting location',
        'route': '/voting-region',
      },
      {
        'icon': Icons.history_outlined,
        'title': 'Voting History',
        'subtitle': 'View your past votes',
        'route': '/history',
      },
      {
        'icon': Icons.security_outlined,
        'title': 'Security Settings',
        'subtitle': 'Manage your account security',
        'route': '/security',
      },
    ];

    return Column(
      children: options.map((option) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: Icon(
              option['icon'] as IconData,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(option['title'] as String),
            subtitle: Text(option['subtitle'] as String),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, option['route'] as String);
            },
          ),
        );
      }).toList(),
    );
  }
}
