import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/notification_badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _unreadNotifications = 2;
  bool _isIdentityVerified = true;
  String _userName = 'John Doe';
  String _userRegion = 'Mumbai, Maharashtra';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildWelcomeCard(context),
              const SizedBox(height: 25),
              _buildActiveElectionCard(context),
              const SizedBox(height: 25),
              _buildQuickActions(context),
              const SizedBox(height: 25),
              _buildVotingStatus(context),
              const SizedBox(height: 25),
              _buildSecurityInfo(context),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildAIAssistantButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'AI',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Vote',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        NotificationBadge(
          count: _unreadNotifications,
          onTap: () => _showNotifications(context),
        ),
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () => _showProfile(context),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.person_outline, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, $_userName',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Your vote matters',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Cast Your Vote',
              onPressed: () => Navigator.pushNamed(context, '/available-elections'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveElectionCard(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.how_to_vote_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text('Active Election'),
                const Spacer(),
                CountdownTimer(
                  endTime: DateTime.now().add(const Duration(days: 2)),
                ),
              ],
            ),
            subtitle: const Text('Mumbai Municipal Elections 2025'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Cast Your Vote Now',
              onPressed: _isIdentityVerified
                  ? () => Navigator.pushNamed(context, '/available-elections')
                  : () => Navigator.pushNamed(context, '/verify'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'icon': Icons.how_to_vote_outlined,
        'label': 'Available\nElections',
        'route': '/available-elections',
      },
      {
        'icon': Icons.verified_user_outlined,
        'label': 'Identity\nVerification',
        'route': '/verify',
      },
      {
        'icon': Icons.history_outlined,
        'label': 'Voting\nHistory',
        'route': '/voting-history',
      },
      {
        'icon': Icons.bar_chart_outlined,
        'label': 'Election\nResults',
        'route': '/election-results',
      },
    ];

    // Calculate the grid item height based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - (48 + 16)) / 2; // Account for padding and spacing
    final itemHeight = itemWidth / 1.5; // Maintain 1.5 aspect ratio

    return SizedBox(
      height: (itemHeight * 2) + 16, // Total height for 2 rows + spacing
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: actions.map((action) {
          return Card(
            margin: EdgeInsets.zero, // Remove default card margin
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, action['route'] as String),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12), // Reduced padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      action['icon'] as IconData,
                      size: 28, // Slightly reduced icon size
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    Text(
                      action['label'] as String,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.1, // Reduced line height
                            fontSize: 13, // Slightly smaller text
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVotingStatus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Voting Status',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildStatusItem(
                  context,
                  'Identity Verified',
                  'Your identity has been verified',
                  Icons.verified_outlined,
                  Colors.green,
                ),
                const SizedBox(height: 16),
                _buildStatusItem(
                  context,
                  'Region Confirmed',
                  _userRegion,
                  Icons.location_on_outlined,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.security_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Security Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Your vote is secured by blockchain technology and protected by AI-powered fraud detection.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Update data
      });
    }
  }

  void _showNotifications(BuildContext context) {
    Navigator.pushNamed(context, '/notifications');
  }

  void _showProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  Widget _buildAIAssistantButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showAIAssistant(context),
      label: const Text('AI Assistant'),
      icon: const Icon(Icons.smart_toy_outlined),
    );
  }

  void _showAIAssistant(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.smart_toy_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Assistant',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'How can I help you today?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        _buildAssistantOption(
                          context,
                          'How to Vote',
                          'Learn about the voting process',
                          Icons.how_to_vote_outlined,
                        ),
                        const SizedBox(height: 16),
                        _buildAssistantOption(
                          context,
                          'Verify Identity',
                          'Get help with identity verification',
                          Icons.verified_user_outlined,
                        ),
                        const SizedBox(height: 16),
                        _buildAssistantOption(
                          context,
                          'Track Vote',
                          'Check your vote status',
                          Icons.track_changes_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAssistantOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
