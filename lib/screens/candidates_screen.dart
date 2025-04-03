import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class CandidatesScreen extends StatelessWidget {
  final Map<String, String> election;

  const CandidatesScreen({
    Key? key,
    required this.election,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidates'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildElectionInfo(),
            const SizedBox(height: 32),
            _buildCandidatesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildElectionInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.people, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            election['name']!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            election['date']!,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidatesList(BuildContext context) {
    // Dummy candidate data for UI testing
    final List<Map<String, String>> candidates = [
      {
        'name': 'Rahul Sharma',
        'party': 'People\'s Party',
        'manifesto': 'Building better infrastructure and healthcare.',
      },
      {
        'name': 'Priya Kapoor',
        'party': 'Progressive Union',
        'manifesto': 'Focus on education and employment for youth.',
      },
    ];

    return Column(
      children: candidates
          .map((candidate) => _buildCandidateCard(context, candidate))
          .toList(),
    );
  }

  Widget _buildCandidateCard(
      BuildContext context, Map<String, String> candidate) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(candidate['name']![0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        candidate['party']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(candidate['manifesto']!),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Vote for Candidate',
              onPressed: () => _handleVoteSelection(context, candidate),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  void _handleVoteSelection(BuildContext context, Map<String, dynamic> candidate) {
    Navigator.pushNamed(
      context,
      '/otp-verification',
      arguments: {
        'name': candidate['name'] ?? 'Unknown',
        'party': candidate['party'] ?? 'Unknown Party',
        'manifesto': candidate['manifesto'] ?? 'No manifesto available',
        'achievements': candidate['achievements'] ?? 'No achievements listed',
      },
    );
  }
}