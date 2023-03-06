import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/extend_user_informs/extend_user_informs.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ExtendUserInformsUsecase implements BaseUseCase<int, ExtendUserInforms> {
  final Repository _repository;
  ExtendUserInformsUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ExtendUserInforms>> execute(int userId) async {
    return await _repository.extendUserInforms(userId);
  }
}
