import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Contrato base para todos os Use Cases.
/// [Type] = tipo de retorno em caso de sucesso.
/// [Params] = parâmetros de entrada (use [NoParams] quando não há).
abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

class NoParams {
  const NoParams();
}
