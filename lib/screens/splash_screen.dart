import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Create scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Start animation
    _controller.forward();

    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/phone-login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background circuit pattern
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
                              Positioned(
                                left: 20,
                                child: Text(
                                  'AI',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
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
                      'AI Vote',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ).createShader(const Rect.fromLTWH(0, 0, 100, 40)),
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Custom painter for circuit pattern
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
    
    for (var i = 1; i < 8; i++) {
      if (i % 2 == 0) {
        canvas.drawLine(
          Offset(0, i * spacing),
          Offset(size.width, i * spacing),
          paint,
        );
        
        for (var j = 1; j < 8; j += 2) {
          canvas.drawCircle(
            Offset(j * spacing, i * spacing),
            2,
            Paint()..color = color,
          );
        }
      }
      
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
