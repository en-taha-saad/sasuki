import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class DeletedManagerUseCase implements BaseUseCase<int, ManagerAction> {
  final Repository _repository;
  DeletedManagerUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerAction>> execute(int managerId) async {
    return await _repository.deleteManager(managerId);
  }
}
