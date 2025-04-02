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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
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
