import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeBanner(context),
            _buildLiveElectionsSection(context),
            _buildPastElectionsSection(context),
            _buildSecuritySection(context),
            _buildHelpSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.how_to_vote, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Text('AI Vote'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () {},
        ),
        PopupMenuButton(
          icon: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person),
          ),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'profile',
              child: Text('Profile'),
            ),
            const PopupMenuItem(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, User',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Next Election: Presidential Election - Starts in 5 days',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Register to Vote',
            onPressed: () {},
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildLiveElectionsSection(BuildContext context) {
    return _buildSection(
      context,
      'Live Elections',
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) => _buildElectionCard(
          context,
          isLive: true,
          title: 'Presidential Election 2024',
          subtitle: 'Time Remaining: 2 days',
          candidates: '5 Candidates',
        ),
      ),
    );
  }

  Widget _buildPastElectionsSection(BuildContext context) {
    return _buildSection(
      context,
      'Past Elections',
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) => _buildElectionCard(
          context,
          isLive: false,
          title: 'Local Council Election 2023',
          subtitle: 'Winner: John Doe',
          candidates: 'Total Votes: 15,234',
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildElectionCard(
    BuildContext context, {
    required bool isLive,
    required String title,
    required String subtitle,
    required String candidates,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(subtitle),
            Text(candidates),
          ],
        ),
        trailing: CustomButton(
          text: isLive ? 'Vote Now' : 'View Results',
          onPressed: () {},
          width: 120,
        ),
      ),
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    return _buildSection(
      context,
      'Security & Transparency',
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Votes Cast: 25,678'),
              const SizedBox(height: 8),
              CustomButton(
                text: 'Verify on Blockchain',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpSection(BuildContext context) {
    return _buildSection(
      context,
      'Help & Support',
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHelpButton(context, Icons.help, 'FAQ'),
          _buildHelpButton(context, Icons.support_agent, 'Support'),
          _buildHelpButton(context, Icons.play_circle, 'Tutorial'),
        ],
      ),
    );
  }

  Widget _buildHelpButton(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[200],
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('© 2024 AI Vote. All rights reserved.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Privacy Policy'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Terms of Use'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
