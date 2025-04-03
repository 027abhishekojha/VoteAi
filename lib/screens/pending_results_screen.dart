import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class PendingResultsScreen extends StatelessWidget {
  const PendingResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            _buildHeader(),
            const SizedBox(height: 32),
            _buildPendingVotesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.pending_actions, size: 48, color: Colors.orange),
          SizedBox(height: 16),
          Text(
            'Pending Vote Verification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Votes that are yet to be verified',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPendingVotesList() {
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
                    child: Text(candidate['name'][0]),
                  ),
                  title: Text(
                    candidate['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(candidate['party']),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pending Votes:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      candidate['pendingVotes'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        candidate['verificationStatus'],
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}