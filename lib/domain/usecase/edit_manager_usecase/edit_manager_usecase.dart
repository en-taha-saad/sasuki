import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class EditManagerUseCase implements BaseUseCase<List, UserAction> {
  final Repository _repository;
  EditManagerUseCase(this._repository);
  @override
  Future<Either<Failure, UserAction>> execute(
    List listOfInputs,
  ) async {
    return await _repository.editManager(listOfInputs[0], listOfInputs[1]);
  }
}
