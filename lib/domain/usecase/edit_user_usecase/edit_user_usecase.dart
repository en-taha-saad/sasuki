import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_action/edit_user.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class EditUserUseCase implements BaseUseCase<List, EditUser> {
  final Repository _repository;
  EditUserUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, EditUser>> execute(List listOfInputs) async {
    return await _repository.editUser(listOfInputs[0], listOfInputs[1]);
  }
}
