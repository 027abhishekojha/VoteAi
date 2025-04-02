import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VoteConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> candidateData;

  const VoteConfirmationScreen({
    Key? key,
    required this.candidateData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Validate required data
    if (!_validateCandidateData()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Invalid candidate data'),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Go Back',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Your Vote'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildCandidateDetails(),
            const SizedBox(height: 32),
            _buildConfirmationButtons(context),
          ],
        ),
      ),
    );
  }

  bool _validateCandidateData() {
    return candidateData.containsKey('name') &&
        candidateData.containsKey('party') &&
        candidateData.containsKey('manifesto') &&
        candidateData.containsKey('achievements') &&
        candidateData['name'] != null &&
        candidateData['party'] != null &&
        candidateData['manifesto'] != null &&
        candidateData['achievements'] != null;
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.how_to_vote, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Review Your Selection',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please review your selection before confirming your vote',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Text(candidateData['name']?.toString().substring(0, 1) ?? '?'),
              ),
              title: Text(
                candidateData['name']?.toString() ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                candidateData['party']?.toString() ?? 'Unknown Party',
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Manifesto', 
              candidateData['manifesto']?.toString() ?? 'No manifesto available'
            ),
            const SizedBox(height: 16),
            _buildInfoSection(
              'Achievements', 
              candidateData['achievements']?.toString() ?? 'No achievements listed'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(content),
      ],
    );
  }

  Widget _buildConfirmationButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomButton(
          text: 'Confirm Vote',
          onPressed: () => _handleVoteConfirmation(context),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Go Back',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  void _handleVoteConfirmation(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/vote-success',
      (route) => false,
      arguments: candidateData,
    );
  }
}