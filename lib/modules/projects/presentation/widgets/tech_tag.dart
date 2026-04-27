import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Badge de tecnologia — ex.: "Flutter", "Firebase".
class TechTag extends StatelessWidget {
  final String label;

  const TechTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.green500.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.green500.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
