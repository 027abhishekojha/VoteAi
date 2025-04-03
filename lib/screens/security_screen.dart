import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSecurityHeader(context),
            const SizedBox(height: 24),
            _buildSecurityOptions(context),
            const SizedBox(height: 24),
            _buildActivityLog(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.security,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Security Status',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green[700],
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Protected',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Security Options',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Biometric Authentication'),
                subtitle: const Text('Use fingerprint or face ID'),
                value: _biometricEnabled,
                onChanged: (value) {
                  setState(() => _biometricEnabled = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Two-Factor Authentication'),
                subtitle: const Text('Additional security for login'),
                value: _twoFactorEnabled,
                onChanged: (value) {
                  setState(() => _twoFactorEnabled = value);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Security Notifications'),
                subtitle: const Text('Get alerts for suspicious activity'),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() => _notificationsEnabled = value);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityLog(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(
                  index == 0 ? Icons.login : Icons.security_update_good,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  index == 0 ? 'Last Login' : 'Security Check',
                ),
                subtitle: Text(
                  index == 0 ? '2 hours ago' : '${index + 1} days ago',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}