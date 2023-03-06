import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_action/manager_action.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class PaydebtManagerUseCase
    implements
        BaseUseCase<DepositWithdrawPayDebtManagerRequestObject, ManagerAction> {
  final Repository _repository;
  PaydebtManagerUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerAction>> execute(
    DepositWithdrawPayDebtManagerRequestObject
        depositWithdrawPayDebtManagerRequestObject,
  ) async {
    return await _repository
        .paydebtManager(depositWithdrawPayDebtManagerRequestObject);
  }
}
