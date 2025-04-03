import 'package:flutter/material.dart';

class VotingHistoryScreen extends StatelessWidget {
  const VotingHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final history = _getDummyHistory();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting History'),
      ),
      body: history.isEmpty 
        ? _buildEmptyState(context)
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            itemBuilder: (context, index) => _buildHistoryCard(context, history[index]),
          ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.how_to_vote_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Voting History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Your voting history will appear here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, String> history) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildElectionInfo(context, history),
            const Divider(height: 24),
            _buildVoteInfo(context, history),
            const SizedBox(height: 16),
            _buildActionButton(context, history),
          ],
        ),
      ),
    );
  }

  Widget _buildElectionInfo(BuildContext context, Map<String, String> history) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.how_to_vote,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                history['election'] ?? 'Unknown Election',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Voted on ${history['date'] ?? 'Unknown Date'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVoteInfo(BuildContext context, Map<String, String> history) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: _buildCandidateImage(history['candidateImage']),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Voted for: ${history['candidateName'] ?? 'Unknown Candidate'}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                history['party'] ?? 'Unknown Party',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        _buildVerificationBadge(context),
      ],
    );
  }

  Widget _buildCandidateImage(String? imagePath) {
    if (imagePath == null) {
      return const Icon(Icons.person_outline);
    }
    
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person_outline);
        },
      ),
    );
  }

  Widget _buildVerificationBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 14,
            color: Colors.green[700],
          ),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: TextStyle(
              color: Colors.green[700],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, Map<String, String> history) {
    return OutlinedButton.icon(
      onPressed: () => _viewVoteDetails(context, history),
      icon: const Icon(Icons.visibility_outlined),
      label: const Text('View Details'),
    );
  }

  void _viewVoteDetails(BuildContext context, Map<String, String> history) {
    // Navigate to vote details page
    Navigator.pushNamed(
      context,
      '/vote-details',
      arguments: history,
    );
  }

  List<Map<String, String>> _getDummyHistory() {
    return [
      {
        'election': 'Mumbai Municipal Elections 2025',
        'date': 'March 15, 2025',
        'candidateName': 'Rahul Sharma',
        'party': "People's Party",
        'candidateImage': 'assets/images/candidate1.jpg',
      },
      {
        'election': 'Maharashtra State Elections 2024',
        'date': 'December 10, 2024',
        'candidateName': 'Priya Patel',
        'party': 'Progressive Union',
        'candidateImage': 'assets/images/candidate2.jpg',
      },
    ];
  }
}