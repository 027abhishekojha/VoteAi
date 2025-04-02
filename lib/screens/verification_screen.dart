import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _faceVerified = false;
  bool _documentVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Identity'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildVerificationStatus(),
            const SizedBox(height: 32),
            _buildVerificationSteps(),
            const SizedBox(height: 32),
            _buildVerifyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.security, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Identity Verification Required',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please complete the verification process to continue voting',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSteps() {
    return Column(
      children: [
        _buildVerificationStep(
          title: 'Face Verification',
          subtitle: 'Scan your face to verify your identity',
          icon: Icons.face,
          isCompleted: _faceVerified,
          onTap: _startFaceVerification,
        ),
        const SizedBox(height: 16),
        _buildVerificationStep(
          title: 'Document Verification',
          subtitle: 'Upload a valid government ID',
          icon: Icons.document_scanner,
          isCompleted: _documentVerified,
          onTap: _startDocumentVerification,
        ),
      ],
    );
  }

  Widget _buildVerificationStep({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: Colors.white,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: CustomButton(
          text: isCompleted ? 'Completed' : 'Start',
          onPressed: isCompleted ? null : onTap,
          width: 100,
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    final bool allVerified = _faceVerified && _documentVerified;
    return CustomButton(
      text: 'Proceed to Vote',
      onPressed: allVerified
          ? () => Navigator.pushNamed(context, '/voting-region')
          : null,
    );
  }

  void _startFaceVerification() {
    // Implement face verification logic here
    setState(() => _faceVerified = true);
  }

  void _startDocumentVerification() {
    // Implement document verification logic here
    setState(() => _documentVerified = true);
  }
}
