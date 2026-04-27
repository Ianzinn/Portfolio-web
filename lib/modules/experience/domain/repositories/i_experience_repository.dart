import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/experience_entity.dart';

abstract class IExperienceRepository {
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences();
}
