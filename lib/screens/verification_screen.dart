import 'package:aivote/screens/Verification_steps.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isFacialRecognitionDone = false;
  bool _isDocumentVerificationDone = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildVerificationSteps(context),
                if (_isFacialRecognitionDone && _isDocumentVerificationDone) ...[
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Complete Verification',
                    onPressed: _completeVerification,
                    isLoading: _isLoading,
                  ),
                ],
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(
            Icons.verified_user_outlined,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Let\'s Verify Your Identity',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Complete these steps to verify your identity',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildVerificationSteps(BuildContext context) {
    return Column(
      children: [
        // Facial Recognition Card
        GestureDetector(
          onTap: _isFacialRecognitionDone ? null : () => _startFacialRecognition(context),
          child: _buildVerificationCard(
            title: 'Facial Recognition',
            subtitle: _isFacialRecognitionDone 
                ? 'Facial Recognition Done ✅' 
                : 'Take a clear selfie for verification',
            icon: Icons.face_outlined,
            isDone: _isFacialRecognitionDone,
          ),
        ),
        const SizedBox(height: 16),
        // Document Verification Card
        GestureDetector(
          onTap: !_isFacialRecognitionDone || _isDocumentVerificationDone 
              ? null 
              : () => _startDocumentVerification(context),
          child: _buildVerificationCard(
            title: 'Document Verification',
            subtitle: _isDocumentVerificationDone 
                ? 'Document Verification Done ✅' 
                : 'Upload a valid government ID',
            icon: Icons.document_scanner_outlined,
            isDone: _isDocumentVerificationDone,
            isEnabled: _isFacialRecognitionDone,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    bool isDone = false,
    bool isEnabled = true,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDone 
              ? Colors.green.withOpacity(0.1)
              : !isEnabled 
                  ? Colors.grey.withOpacity(0.1)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isDone ? Icons.check_circle : icon,
                color: isDone 
                    ? Colors.green
                    : !isEnabled 
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            if (!isDone && isEnabled)
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _startFacialRecognition(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/facial-recognition');
    if (result == true && mounted) {
      setState(() => _isFacialRecognitionDone = true);
    }
  }

  Future<void> _startDocumentVerification(BuildContext context) async {
    if (!_isFacialRecognitionDone) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete facial recognition first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = await Navigator.pushNamed(context, '/document-upload');
    if (result == true && mounted) {
      setState(() => _isDocumentVerificationDone = true);
    }
  }

  Future<void> _completeVerification() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
