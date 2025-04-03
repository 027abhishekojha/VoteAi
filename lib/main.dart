import 'package:aivote/screens/candidates_screen.dart';
import 'package:aivote/screens/otp_verification_screen.dart';
import 'package:aivote/screens/pending_results_screen.dart';
import 'package:aivote/screens/vote_confirmation_screen.dart';
import 'package:aivote/screens/vote_result_summary_screen.dart';
import 'package:aivote/screens/vote_success_screen.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/vote_screen.dart';
import 'screens/results_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/create_vote_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/voting_region_screen.dart';
import 'screens/available_elections_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/voting_history_screen.dart';
import 'screens/election_results_screen.dart';
import 'screens/security_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Vote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF50)),
        useMaterial3: true,
        // Add custom font
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/candidates') {
          final args = settings.arguments as Map<String, String>?;
          return MaterialPageRoute(
            builder: (context) => CandidatesScreen(
              election: args ?? {'error': 'No election data provided'},
            ),
          );
        }
        if (settings.name == '/vote-confirmation') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => VoteConfirmationScreen(
              candidateData: args ?? {'error': 'No candidate data provided'},
            ),
          );
        }
        if (settings.name == '/vote-success') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => VoteSuccessScreen(
              voteData: args ?? {'error': 'No vote data provided'},
            ),
          );
        }
        if (settings.name == '/otp-verification') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              candidateData: args ?? {'error': 'No candidate data provided'},
            ),
          );
        }
        return null;
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/verify': (context) => const VerificationScreen(),
        '/verification': (context) => const VerificationScreen(),
        '/voting-region': (context) => const VotingRegionScreen(),
        '/available-elections': (context) => const AvailableElectionsScreen(),
        '/vote-result-summary': (context) => const VoteResultSummaryScreen(),
        '/pending-results': (context) => const PendingResultsScreen(),
        '/vote-success': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
          return VoteSuccessScreen(
            voteData: args ?? {'error': 'No vote data provided'},
          );
        },
        '/notifications': (context) => const NotificationsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/voting-history': (context) => const VotingHistoryScreen(),
        '/election-results': (context) => const ElectionResultsScreen(),
        '/security': (context) => const SecurityScreen(),
      },
    );
  }
}

class PagesPreview extends StatelessWidget {
  const PagesPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        'title': 'Home',
        'icon': Icons.home,
        'widget': const HomeScreen(),
      },
      {
        'title': 'Vote',
        'icon': Icons.how_to_vote,
        'widget': const VoteScreen(),
      },
      {
        'title': 'Create Vote',
        'icon': Icons.add_box,
        'widget': const CreateVoteScreen(),
      },
      {
        'title': 'Results',
        'icon': Icons.poll,
        'widget': const ResultsScreen(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person,
        'widget': const ProfileScreen(),
      },
      {
        'title': 'Settings',
        'icon': Icons.settings,
        'widget': const SettingsScreen(),
      },
      {
        'title': 'Login Page',
        'icon': Icons.login,
        'widget': const LoginScreen(),
      },
      {
        'title': 'Signup Page',
        'icon': Icons.login,
        'widget': const SignupScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pages Preview'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(pages[index]['icon']),
            title: Text(pages[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pages[index]['widget'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
