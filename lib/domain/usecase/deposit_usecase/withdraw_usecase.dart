import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_action/user_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class WithdrawUsecase
    implements BaseUseCase<DepositWithdrawUserRequestObject, UserAction> {
  final Repository _repository;
  WithdrawUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, UserAction>> execute(
    DepositWithdrawUserRequestObject depositWithdrawUserRequestObject,
  ) async {
    return await _repository.withdraw(depositWithdrawUserRequestObject);
  }
}
