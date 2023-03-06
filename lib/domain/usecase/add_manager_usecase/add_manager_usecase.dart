import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_action/edit_user.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class AddManagerUseCase
    implements BaseUseCase<AddEditManagerRequestObject, EditUser> {
  final Repository _repository;
  AddManagerUseCase(this._repository);
  @override
  Future<Either<Failure, EditUser>> execute(
    AddEditManagerRequestObject addEditManagerRequestObject,
  ) async {
    return await _repository.addManager(addEditManagerRequestObject);
  }
}
