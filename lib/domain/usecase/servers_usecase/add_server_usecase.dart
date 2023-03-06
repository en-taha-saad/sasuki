import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class AddServerUseCase implements BaseUseCase<Server?, bool?> {
  final Repository _repository;

  AddServerUseCase(this._repository);

  @override
  Future<Either<Failure, bool?>> execute(Server? server) async {
    return await _repository.addServer(server);
  }
}
