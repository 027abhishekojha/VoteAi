import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class VotingRegionScreen extends StatefulWidget {
  const VotingRegionScreen({Key? key}) : super(key: key);

  @override
  State<VotingRegionScreen> createState() => _VotingRegionScreenState();
}

class _VotingRegionScreenState extends State<VotingRegionScreen> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Voting Region'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildLocationSelectors(),
            const SizedBox(height: 32),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.location_on, size: 48, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'Select Your Voting Region',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose your location to see available elections',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelectors() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDropdown(
              'Select Country',
              ['India', 'United States', 'United Kingdom'],
              selectedCountry,
              (value) => setState(() {
                selectedCountry = value;
                selectedState = null;
                selectedCity = null;
              }),
            ),
            const SizedBox(height: 16),
            if (selectedCountry != null)
              _buildDropdown(
                'Select State',
                ['Maharashtra', 'Delhi', 'Karnataka'],
                selectedState,
                (value) => setState(() {
                  selectedState = value;
                  selectedCity = null;
                }),
              ),
            if (selectedState != null) const SizedBox(height: 16),
            if (selectedState != null)
              _buildDropdown(
                'Select City',
                ['Mumbai', 'Pune', 'Nagpur'],
                selectedCity,
                (value) => setState(() => selectedCity = value),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? value,
    void Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildNextButton() {
    final bool canProceed = selectedCountry != null &&
        selectedState != null &&
        selectedCity != null;

    return CustomButton(
      text: 'View Available Elections',
      onPressed: canProceed
          ? () => Navigator.pushNamed(context, '/available-elections')
          : null,
      isLoading: isLoading,
    );
  }
}