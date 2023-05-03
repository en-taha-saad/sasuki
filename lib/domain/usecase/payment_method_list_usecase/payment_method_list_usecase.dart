import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/payment_methods/payment_methods.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class PaymentMethodListUsecase implements BaseUseCase<void, PaymentMethods> {
  final Repository _repository;
  PaymentMethodListUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, PaymentMethods>> execute(void input) async {
    return await _repository.getPaymentMethods();
  }
}
