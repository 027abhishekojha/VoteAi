import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class AvailableElectionsScreen extends StatelessWidget {
  const AvailableElectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Elections'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildElectionsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          Icon(Icons.how_to_vote, size: 48, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Available Elections',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select an election to view candidates and cast your vote',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildElectionsList() {
    // Dummy data for UI testing
    final List<Map<String, String>> elections = [
      {
        'name': 'Mumbai Municipal Elections 2025',
        'date': 'Voting Ends: April 10, 2025',
        'status': 'Ongoing'
      },
      {
        'name': 'Maharashtra State Assembly Elections',
        'date': 'Voting Ends: April 15, 2025',
        'status': 'Ongoing'
      },
    ];

    return Column(
      children: elections
          .map((election) => _buildElectionCard(election))
          .toList(),
    );
  }

  Widget _buildElectionCard(Map<String, String> election) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.ballot, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    election['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              election['date']!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
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
                  child: Text(
                    election['status']!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                // CustomButton(
                //   text: 'View Candidates',
                //   onPressed: () => Navigator.pushNamed(
                //     context,
                //     '/candidates',
                //     arguments: election,
                //   ),
                //   width: 150,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}