import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project_entity.dart';

/// Contrato (interface) que define o que o repositório deve fornecer.
/// A Data Layer é responsável por implementar este contrato.
abstract class IProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
}
