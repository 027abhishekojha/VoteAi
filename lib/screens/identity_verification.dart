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
  bool _isDocumentUploadDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildVerificationSteps(context),
          ],
        ),
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
        VerificationStepCard(
          title: 'Facial Recognition',
          subtitle: 'Take a clear selfie for verification',
          icon: Icons.face_outlined,
          isDone: _isFacialRecognitionDone,
          onPressed: _isFacialRecognitionDone
              ? null
              : () => _startFacialRecognition(context),
        ),
        const SizedBox(height: 16),
        VerificationStepCard(
          title: 'Document Upload',
          subtitle: 'Upload a valid government ID',
          icon: Icons.upload_file_outlined,
          isDone: _isDocumentUploadDone,
          isEnabled: _isFacialRecognitionDone,
          onPressed: !_isFacialRecognitionDone || _isDocumentUploadDone
              ? null
              : () => _startDocumentUpload(context),
        ),
        const SizedBox(height: 32),
        if (_isFacialRecognitionDone && _isDocumentUploadDone)
          CustomButton(
            text: 'Complete Verification',
            onPressed: _completeVerification,
          ),
      ],
    );
  }

  Future<void> _startFacialRecognition(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/facial-recognition');
    if (result == true && mounted) {
      setState(() => _isFacialRecognitionDone = true);
    }
  }

  Future<void> _startDocumentUpload(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/document-upload');
    if (result == true && mounted) {
      setState(() => _isDocumentUploadDone = true);
    }
  }

  Future<void> _completeVerification() async {
    Navigator.pushReplacementNamed(context, '/home');
  }
}