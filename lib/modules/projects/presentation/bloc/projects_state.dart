part of 'projects_bloc.dart';

sealed class ProjectsState {
  const ProjectsState();
}

final class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

final class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

final class ProjectsLoaded extends ProjectsState {
  const ProjectsLoaded(this.projects);
  final List<ProjectEntity> projects;
}

final class ProjectsError extends ProjectsState {
  const ProjectsError(this.message);
  final String message;
}
