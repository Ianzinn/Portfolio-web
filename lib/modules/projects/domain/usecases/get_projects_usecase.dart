import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/project_entity.dart';
import '../repositories/i_projects_repository.dart';

/// Caso de uso responsável por buscar a lista de projetos.
/// Contém apenas regra de negócio — sem conhecimento de UI ou fonte de dados.
class GetProjectsUseCase implements UseCase<List<ProjectEntity>, NoParams> {
  final IProjectsRepository repository;

  GetProjectsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(NoParams params) {
    return repository.getProjects();
  }
}
