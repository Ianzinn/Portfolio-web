import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Cabeçalho de seção estilo "código":
///   /* Featured Projects */
///   const Projetos em Destaque = [
class SectionHeader extends StatelessWidget {
  final String comment;
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.comment,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // /* comment */
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
            children: [
              const TextSpan(
                text: '/* ',
                style: TextStyle(color: AppTheme.green500),
              ),
              TextSpan(
                text: comment,
                style: const TextStyle(color: AppTheme.slate500),
              ),
              const TextSpan(
                text: ' */',
                style: TextStyle(color: AppTheme.green500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // const title = [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
            children: [
              const TextSpan(
                text: 'const ',
                style: TextStyle(color: AppTheme.green500),
              ),
              TextSpan(
                text: title,
                style: const TextStyle(color: Colors.white),
              ),
              const TextSpan(
                text: ' = [',
                style: TextStyle(color: AppTheme.green500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppTheme.slate400,
            fontSize: 16,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
