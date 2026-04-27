import 'package:get_it/get_it.dart';

// Projects
import 'modules/projects/data/datasources/projects_local_datasource.dart';
import 'modules/projects/data/repositories/projects_repository_impl.dart';
import 'modules/projects/domain/repositories/i_projects_repository.dart';
import 'modules/projects/domain/usecases/get_projects_usecase.dart';
import 'modules/projects/presentation/bloc/projects_bloc.dart';

// Experience
import 'modules/experience/data/datasources/experience_local_datasource.dart';
import 'modules/experience/data/repositories/experience_repository_impl.dart';
import 'modules/experience/domain/repositories/i_experience_repository.dart';
import 'modules/experience/domain/usecases/get_experience_usecase.dart';
import 'modules/experience/presentation/bloc/experience_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Projects ───────────────────────────────────────────────────────────────
  sl.registerFactory(
    () => ProjectsBloc(getProjectsUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetProjectsUseCase(sl()));
  sl.registerLazySingleton<IProjectsRepository>(
    () => ProjectsRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<IProjectsLocalDataSource>(
    () => ProjectsLocalDataSource(),
  );

  // ── Experience ─────────────────────────────────────────────────────────────
  sl.registerFactory(
    () => ExperienceBloc(getExperienceUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetExperienceUseCase(sl()));
  sl.registerLazySingleton<IExperienceRepository>(
    () => ExperienceRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<IExperienceLocalDataSource>(
    () => ExperienceLocalDataSource(),
  );
}
