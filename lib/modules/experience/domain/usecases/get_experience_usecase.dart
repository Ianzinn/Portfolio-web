import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/experience_entity.dart';
import '../repositories/i_experience_repository.dart';

class GetExperienceUseCase
    implements UseCase<List<ExperienceEntity>, NoParams> {
  final IExperienceRepository repository;

  GetExperienceUseCase(this.repository);

  @override
  Future<Either<Failure, List<ExperienceEntity>>> call(NoParams params) {
    return repository.getExperiences();
  }
}
