abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erro no servidor']);
}

class LocalDataFailure extends Failure {
  const LocalDataFailure([super.message = 'Erro ao carregar dados locais']);
}
