import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VoteSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> voteData;

  const VoteSuccessScreen({
    Key? key,
    required this.voteData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 32),
              Text(
                'Vote Cast Successfully!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your vote for ${voteData['name']} has been recorded securely.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: 'View Vote Result Summary',
                onPressed: () => Navigator.pushNamed(context, '/vote-result-summary'),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'View Pending Votes',
                onPressed: () => Navigator.pushNamed(context, '/pending-results'),
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                ),
                child: const Text('Return to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}