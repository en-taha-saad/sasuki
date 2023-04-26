import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/managers_invoices/managers_invoices.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ManagerInvoicesUsecase
    implements BaseUseCase<ManagerInvoicesRequestObject, ManagersInvoices> {
  final Repository _repository;
  ManagerInvoicesUsecase(this._repository);
  @override
  Future<Either<Failure, ManagersInvoices>> execute(
    ManagerInvoicesRequestObject managerInvoicesRequestObject,
  ) async {
    return await _repository.getManagerInvoices(managerInvoicesRequestObject);
  }
}
