import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/repositories/i_experience_repository.dart';
import '../datasources/experience_local_datasource.dart';

class ExperienceRepositoryImpl implements IExperienceRepository {
  final IExperienceLocalDataSource localDataSource;

  ExperienceRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ExperienceEntity>>> getExperiences() async {
    try {
      final models = await localDataSource.getExperiences();
      return Right(models);
    } catch (e) {
      return Left(LocalDataFailure(e.toString()));
    }
  }
}
