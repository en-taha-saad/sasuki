import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class RemoveServerUsecase implements BaseUseCase<String?, bool?> {
  final Repository _repository;

  RemoveServerUsecase(this._repository);

  @override
  Future<Either<Failure, bool?>> execute(String? serverName) async {
    return await _repository.removeServer(serverName);
  }
}
