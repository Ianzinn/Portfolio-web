part of 'projects_bloc.dart';

sealed class ProjectsEvent {
  const ProjectsEvent();
}

/// Disparado quando a tela de projetos é inicializada.
final class LoadProjectsEvent extends ProjectsEvent {
  const LoadProjectsEvent();
}
