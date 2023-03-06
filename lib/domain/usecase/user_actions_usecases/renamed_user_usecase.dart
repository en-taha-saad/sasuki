import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class RenamedUserUseCase implements BaseUseCase<List, UserAction> {
  final Repository _repository;
  RenamedUserUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, UserAction>> execute(
      List listOfRenameOptionsRequest) async {
    return await _repository.renameUser(
      listOfRenameOptionsRequest[0],
      listOfRenameOptionsRequest[1],
    );
  }
}
