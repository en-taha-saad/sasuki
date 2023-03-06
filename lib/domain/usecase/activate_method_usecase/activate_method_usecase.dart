import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/activate_method/activate_method.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ActivateMethodUseCase
    implements BaseUseCase<ActivationRequestObject, ActivateMethod> {
  final Repository _repository;
  ActivateMethodUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ActivateMethod>> execute(
      ActivationRequestObject activationRequestObject) async {
    return await _repository.activateUser(activationRequestObject);
  }
}
