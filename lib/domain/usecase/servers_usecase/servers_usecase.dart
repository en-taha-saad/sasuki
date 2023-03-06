import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/choosing_server/servers.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ChooseServerUseCase implements BaseUseCase<void, ServersList> {
  final Repository _repository;

  ChooseServerUseCase(this._repository);

  @override
  Future<Either<Failure, ServersList>> execute(void input) async {
    return await _repository.getServers();
  }
}
