import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/paydebt_informs/paydebt_informs.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class PayDebtInformsUsecase implements BaseUseCase<int, PaydebtInforms> {
  final Repository _repository;
  PayDebtInformsUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, PaydebtInforms>> execute(int userId) async {
    return await _repository.getPayDebtInforms(userId);
  }
}
