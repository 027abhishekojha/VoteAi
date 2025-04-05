import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_button.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushNamed(
        context,
        '/otp-verification',
        arguments: _phoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _buildLogo(context),
              const SizedBox(height: 48),
              _buildPhoneInput(context),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Send OTP',
                onPressed: _sendOTP,
                isLoading: _isLoading,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.phone_android,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Phone Verification',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your phone number to continue',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: '1234567890',
        prefixText: '+91 ',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}