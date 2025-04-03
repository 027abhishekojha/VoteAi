import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class PendingResultsScreen extends StatelessWidget {
  const PendingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get MediaQuery data correctly
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Votes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildPendingVotesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.pending_actions,
            size: 48,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            'Pending Vote Verification',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Votes that are yet to be verified',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildPendingVotesList(BuildContext context) {
    // Dummy data for testing
    final List<Map<String, dynamic>> candidates = [
      {
        'name': 'Rahul Sharma',
        'party': "People's Party",
        'pendingVotes': 1520,
        'verificationStatus': 'In Progress',
      },
      {
        'name': 'Priya Patel',
        'party': 'Progressive Union',
        'pendingVotes': 980,
        'verificationStatus': 'Queued',
      },
    ];

    return Column(
      children: candidates.map((candidate) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      candidate['name'][0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    candidate['name'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    candidate['party'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pending Votes:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    Text(
                      candidate['pendingVotes'].toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    _buildStatusBadge(context, candidate['verificationStatus']),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
      ),
    );
  }
}