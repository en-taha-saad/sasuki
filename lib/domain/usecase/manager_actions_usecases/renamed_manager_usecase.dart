import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class RenamedManagerUseCase implements BaseUseCase<List, ManagerAction> {
  final Repository _repository;
  RenamedManagerUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerAction>> execute(
      List listOfRenameOptionsRequest) async {
    return await _repository.renameManager(
      listOfRenameOptionsRequest[0],
      listOfRenameOptionsRequest[1],
    );
  }
}
