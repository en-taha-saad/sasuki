import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/activation_informs/activation_informs.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ActivationInformsUsecase implements BaseUseCase<int, ActivationInforms> {
  final Repository _repository;
  ActivationInformsUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ActivationInforms>> execute(int userId) async {
    return await _repository.getActivationInforms(userId);
  }
}
