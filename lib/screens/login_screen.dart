import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }   

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _handleSignIn() async {
    if (_isLoading) return;

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulate API call
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildLoginForm(),
                    const SizedBox(height: 24),
                    _buildSignUpLink(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Animated circuit pattern background
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: CircuitPatternPainter(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
              ),
            ),
            // Main logo container
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // AI Text with neon effect
                  Positioned(
                    left: 20,
                    child: Text(
                      'AI',
                      style: TextStyle(
                        fontFamily: 'Orbitron', // You'll need to add this font
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.8),
                            ],
                          ).createShader(const Rect.fromLTWH(0, 0, 50, 40)),
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.8),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Vote icon
                  const Positioned(
                    right: 20,
                    child: Icon(
                      Icons.how_to_vote_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Secure Voting with AI',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
              ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Email is required';
              if (!_isValidEmail(value!)) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: _passwordController,
            isPassword: true,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Password is required';
              if ((value?.length ?? 0) < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Sign In',
            onPressed: _handleSignIn,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/signup'),
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

// Add this custom painter class at the bottom of the file
class NeuralNetworkPainter extends CustomPainter {
  final Color color;

  NeuralNetworkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final nodeRadius = 3.0;
    final nodePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw neural network nodes and connections
    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        final x = size.width * (i + 1) / 6;
        final y = size.height * (j + 1) / 6;

        // Draw node
        canvas.drawCircle(Offset(x, y), nodeRadius, nodePaint);

        // Draw connections
        if (i < 4) {
          canvas.drawLine(
            Offset(x, y),
            Offset(size.width * (i + 2) / 6, size.height * (j + 1) / 6),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Add this custom painter class for the circuit pattern
class CircuitPatternPainter extends CustomPainter {
  final Color color;

  CircuitPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double spacing = size.width / 8;
    
    // Draw horizontal and vertical lines
    for (var i = 1; i < 8; i++) {
      // Horizontal lines with dots
      if (i % 2 == 0) {
        canvas.drawLine(
          Offset(0, i * spacing),
          Offset(size.width, i * spacing),
          paint,
        );
        
        // Add connection dots
        for (var j = 1; j < 8; j += 2) {
          canvas.drawCircle(
            Offset(j * spacing, i * spacing),
            2,
            Paint()..color = color,
          );
        }
      }
      
      // Vertical lines with dots
      if (i % 2 == 0) {
        canvas.drawLine(
          Offset(i * spacing, 0),
          Offset(i * spacing, size.height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
