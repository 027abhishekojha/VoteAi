import 'package:flutter/material.dart';

class VerificationStepCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDone;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const VerificationStepCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDone = false,
    this.isEnabled = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isClickable = isEnabled && !isDone && onPressed != null;

    return Card(
      child: InkWell(
        onTap: isClickable ? onPressed : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDone ? Icons.check : icon,
                  color: _getIconColor(context),
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
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              if (isClickable)
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isDone) return Colors.green.withOpacity(0.1);
    if (!isEnabled) return Colors.grey.withOpacity(0.1);
    return Theme.of(context).colorScheme.primary.withOpacity(0.1);
  }

  Color _getIconColor(BuildContext context) {
    if (isDone) return Colors.green;
    if (!isEnabled) return Colors.grey;
    return Theme.of(context).colorScheme.primary;
  }
}