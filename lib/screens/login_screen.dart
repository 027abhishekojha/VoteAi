import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'signup_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF4CAF50),  // Fresh green
                              const Color(0xFF81C784),  // Light green
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4CAF50).withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.how_to_vote_rounded,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 40),
                    // Text(
                    //   'Welcome Back!',
                    //   style: Theme.of(context).textTheme.displayLarge,
                    // ),
                    const SizedBox(height: 12),
                    // Text(
                    //   'Sign in to continue to AI Vote',
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Email',
                            hint: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                value?.isEmpty ?? true ? 'Email is required' : null,
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,
                            isPassword: true,
                            validator: (value) =>
                                value?.isEmpty ?? true ? 'Password is required' : null,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Handle login
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Or continue with',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialButton(
                                'assets/icons/google.png',
                                () {},
                                'Google',
                              ),
                              _buildSocialButton(
                                'assets/icons/facebook.png',
                                () {},
                                'Facebook',
                              ),
                              _buildSocialButton(
                                'assets/icons/apple.png',
                                () {},
                                'Apple',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                            onPressed: () {
                              Navigator.push() {},
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),orScheme.primary,
                              );ontWeight.bold,
                            },fontSize: 18,
                            child: Text(),
                              'Sign Up',),
                              style: TextStyle(),
                                color: Theme.of(context).colorScheme.primary,],
                                fontWeight: FontWeight.bold,),
                                fontSize: 18,
                              ),const SizedBox(height: 20),
                            ),],
                          ),),
                        ],),
                      ),),
                    ),),
                    const SizedBox(height: 20),),
                  ],),
                ), );
              ),  }
            ),
          ),alButton(String iconPath, VoidCallback onTap, String label) {
        ),
      ),in with $label',
    );
  }
derRadius.circular(16),
  Widget _buildSocialButton(String iconPath, VoidCallback onTap, String label) {
    return Tooltip(all(16),
      message: 'Sign in with $label',
      child: InkWell(0]!),
        onTap: onTap,borderRadius: BorderRadius.circular(16),
        borderRadius: BorderRadius.circular(16),
        child: Container(e.asset(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(,
            border: Border.all(color: Colors.grey[200]!),width: 32,
            borderRadius: BorderRadius.circular(16),),
          ),),
          child: Image.asset(),
            iconPath, );
            height: 32, }
            width: 32,}







}  }    );      ),        ),          ),