import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/choosing_server/server.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class SelectedServerUsecase implements BaseUseCase<void, Server?> {
  final Repository _repository;

  SelectedServerUsecase(this._repository);

  @override
  Future<Either<Failure, Server?>> execute(void input) async {
    return await _repository.getSelectedServer();
  }
}
