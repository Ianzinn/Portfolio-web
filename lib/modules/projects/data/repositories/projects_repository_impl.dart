import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/i_projects_repository.dart';
import '../datasources/projects_local_datasource.dart';

/// Implementação concreta do repositório.
/// Conhece a fonte de dados e trata erros transformando-os em [Failure].
class ProjectsRepositoryImpl implements IProjectsRepository {
  final IProjectsLocalDataSource localDataSource;

  ProjectsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      final models = await localDataSource.getProjects();
      return Right(models);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }
}
