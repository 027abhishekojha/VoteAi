import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ElectionResultsScreen extends StatelessWidget {
  const ElectionResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Election Results'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Current Results'),
              Tab(text: 'Past Elections'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCurrentResults(context),
            _buildPastResults(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentResults(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mumbai Municipal Elections 2025',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Live Results',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: 35,
                            title: '35%',
                            color: Colors.blue,
                          ),
                          PieChartSectionData(
                            value: 40,
                            title: '40%',
                            color: Colors.green,
                          ),
                          PieChartSectionData(
                            value: 25,
                            title: '25%',
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildCandidateResults(context),
        ],
      ),
    );
  }

  Widget _buildCandidateResults(BuildContext context) {
    final candidates = [
      {
        'name': 'Rahul Sharma',
        'party': "People's Party",
        'votes': 10230,
        'percentage': 40,
        'color': Colors.green,
      },
      {
        'name': 'Priya Patel',
        'party': 'Progressive Union',
        'votes': 8975,
        'percentage': 35,
        'color': Colors.blue,
      },
      {
        'name': 'Ahmed Khan',
        'party': 'Democratic Front',
        'votes': 6410,
        'percentage': 25,
        'color': Colors.orange,
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
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: candidate['color'] as Color,
                      child: Text(
                        candidate['name'].toString()[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidate['name'].toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            candidate['party'].toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${candidate['votes']} votes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${candidate['percentage']}%',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: (candidate['percentage'] as int) / 100,
                  color: candidate['color'] as Color,
                  backgroundColor: (candidate['color'] as Color).withOpacity(0.1),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPastResults(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text('Maharashtra State Elections ${2024 - index}'),
            subtitle: const Text('View detailed results'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to detailed past results
            },
          ),
        );
      },
    );
  }
}