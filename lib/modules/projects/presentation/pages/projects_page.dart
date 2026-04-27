import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../injection_container.dart';
import '../bloc/projects_bloc.dart';
import '../widgets/project_card.dart';
import '../widgets/section_header.dart';

/// Página standalone (com Scaffold próprio) para uso direto via rota.
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.slate950,
      body: SingleChildScrollView(child: const ProjectsPageContent()),
    );
  }
}

/// Widget embeddável: cria o BlocProvider e exibe o conteúdo da seção
/// sem Scaffold nem ScrollView — para ser usado dentro da HomePage.
class ProjectsPageContent extends StatelessWidget {
  const ProjectsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProjectsBloc>()..add(const LoadProjectsEvent()),
      child: const _ProjectsBody(),
    );
  }
}

class _ProjectsBody extends StatelessWidget {
  const _ProjectsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) => switch (state) {
        ProjectsInitial() || ProjectsLoading() => const Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: CircularProgressIndicator(color: AppTheme.green500),
            ),
          ),
        ProjectsError(:final message) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppTheme.red500, size: 48),
                  const SizedBox(height: 16),
                  Text(message,
                      style: const TextStyle(
                          color: AppTheme.slate400,
                          fontFamily: 'monospace')),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => context
                        .read<ProjectsBloc>()
                        .add(const LoadProjectsEvent()),
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.projectsButtonRetry),
                  ),
                ],
              ),
            ),
          ),
        ProjectsLoaded() => _ProjectsContent(state: state),
      },
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  final ProjectsLoaded state;
  const _ProjectsContent({required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      color: AppTheme.slate900.withValues(alpha: 0.5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              SectionHeader(
                comment: context.l10n.projectsSectionComment,
                title: context.l10n.projectsSectionTitle,
                subtitle: context.l10n.projectsSectionSubtitle,
              ),
              const SizedBox(height: 64),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth <= 768;
                  if (isMobile) {
                    return Column(
                      children: [
                        for (int i = 0; i < state.projects.length; i++) ...[
                          ProjectCard(
                            project: state.projects[i],
                            index: i,
                            isMobile: true,
                          ),
                          if (i < state.projects.length - 1)
                            const SizedBox(height: 24),
                        ],
                      ],
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 32,
                      mainAxisExtent: 530,
                    ),
                    itemCount: state.projects.length,
                    itemBuilder: (_, i) =>
                        ProjectCard(project: state.projects[i], index: i),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Text(
                '];',
                style: TextStyle(
                    color: AppTheme.green500,
                    fontSize: 24,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
