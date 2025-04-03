import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VoteResultSummaryScreen extends StatelessWidget {
  const VoteResultSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vote Result Summary'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildResultsList(),
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
      child: const Column(
        children: [
          Icon(Icons.how_to_vote, size: 48, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Current Election Results',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Live vote count for all candidates',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    // Dummy data for testing
    final List<Map<String, dynamic>> candidates = [
      {
        'name': 'Rahul Sharma',
        'party': "People's Party",
        'votes': 10230,
      },
      {
        'name': 'Priya Patel',
        'party': 'Progressive Union',
        'votes': 9480,
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
                      'Votes Received:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      candidate['votes'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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