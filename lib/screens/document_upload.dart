import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_button.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final Map<String, String?> _uploadedDocuments = {
    'voter_id': null,
    'aadhaar': null,
    'pan': null,
  };
  
  int _currentStep = 0;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _documentSteps = [
    {
      'type': 'voter_id',
      'name': 'Voter ID',
      'icon': Icons.how_to_vote_outlined,
      'hint': 'Upload your Voter ID card',
    },
    {
      'type': 'aadhaar',
      'name': 'Aadhaar Card',
      'icon': Icons.credit_card_outlined,
      'hint': 'Upload your Aadhaar card',
    },
    {
      'type': 'pan',
      'name': 'PAN Card',
      'icon': Icons.account_balance_outlined,
      'hint': 'Upload your PAN card',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStepIndicator(),
                const SizedBox(height: 32),
                _buildCurrentStep(),
                if (_allDocumentsUploaded()) ...[
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Submit All Documents',
                    onPressed: _submitDocuments,
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

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(
        _documentSteps.length,
        (index) => Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: index <= _currentStep
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    final currentDoc = _documentSteps[_currentStep];
    final docType = currentDoc['type'] as String;
    final isUploaded = _uploadedDocuments[docType] != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Step ${_currentStep + 1} of ${_documentSteps.length}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Upload ${currentDoc['name']}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 24),
        if (!isUploaded)
          _buildUploadCard(currentDoc)
        else
          _buildUploadedPreview(currentDoc),
        const SizedBox(height: 24),
        if (isUploaded && _currentStep < _documentSteps.length - 1)
          CustomButton(
            text: 'Continue to Next Document',
            onPressed: () {
              setState(() => _currentStep++);
            },
          ),
      ],
    );
  }

  Widget _buildUploadCard(Map<String, dynamic> doc) {
    return Card(
      child: InkWell(
        onTap: () => _showImageSourceDialog(doc['type']),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                doc['icon'] as IconData,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                doc['hint'] as String,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to upload',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedPreview(Map<String, dynamic> doc) {
    final docType = doc['type'] as String;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc['name'] as String,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Document uploaded successfully',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() => _uploadedDocuments[docType] = null);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog(String docType) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera, docType);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery, docType);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, String docType) async {
    final picker = ImagePicker();
    
    try {
      final image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() => _uploadedDocuments[docType] = image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error selecting image')),
      );
    }
  }

  bool _allDocumentsUploaded() {
    return !_uploadedDocuments.values.contains(null);
  }

  Future<void> _submitDocuments() async {
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Documents uploaded successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    }
  }
}