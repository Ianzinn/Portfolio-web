import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/experience_bloc.dart';
import 'experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ExperienceBloc>()..add(const LoadExperienceEvent()),
      child: const _ExperienceView(),
    );
  }
}

class _ExperienceView extends StatelessWidget {
  const _ExperienceView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 896),
          child: Column(
            children: [
              // Header (JSDoc style)
              const Text('/**',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 14,
                      fontFamily: 'monospace')),
              const SizedBox(height: 16),
              Text(
                context.l10n.experienceSectionTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),
              const Text('* @version 1.0',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 14,
                      fontFamily: 'monospace')),
              const SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style:
                      const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                  children: [
                    const TextSpan(
                        text: '* @description ',
                        style: TextStyle(color: AppTheme.green500)),
                    TextSpan(
                        text: context.l10n.experienceSectionDescription,
                        style: const TextStyle(color: AppTheme.slate400)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text('*/',
                  style: TextStyle(
                      color: AppTheme.green500,
                      fontSize: 14,
                      fontFamily: 'monospace')),
              const SizedBox(height: 64),
              // Timeline list
              BlocBuilder<ExperienceBloc, ExperienceState>(
                builder: (context, state) => switch (state) {
                  ExperienceInitial() || ExperienceLoading() => const Center(
                      child: CircularProgressIndicator(
                          color: AppTheme.green500)),
                  ExperienceError(:final message) => Center(
                      child: Text(message,
                          style: const TextStyle(
                              color: AppTheme.red500,
                              fontFamily: 'monospace'))),
                  ExperienceLoaded(:final experiences) =>
                    LayoutBuilder(builder: (ctx, constraints) {
                      final showTimeline = constraints.maxWidth > 600;
                      return Column(
                        children: experiences
                            .map((e) => ExperienceCard(
                                  experience: e,
                                  showTimeline: showTimeline,
                                ))
                            .toList(),
                      );
                    }),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
