import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects_usecase.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectsUseCase getProjectsUseCase;

  ProjectsBloc({required this.getProjectsUseCase}) : super(ProjectsInitial()) {
    on<LoadProjectsEvent>(_onLoadProjects);
  }

  Future<void> _onLoadProjects(
    LoadProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(ProjectsLoading());

    final result = await getProjectsUseCase(const NoParams());

    result.fold(
      (failure) => emit(ProjectsError(failure.message)),
      (projects) => emit(ProjectsLoaded(projects)),
    );
  }
}
