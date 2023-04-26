import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/activations_reports/activations_reports.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ActivationsReportsUsecase
    implements BaseUseCase<ActivationReportsRequestObject, ActivationsReports> {
  final Repository _repository;
  ActivationsReportsUsecase(this._repository);
  @override
  Future<Either<Failure, ActivationsReports>> execute(
    ActivationReportsRequestObject activationReportsRequestObject,
  ) async {
    return await _repository
        .getActivationsReports(activationReportsRequestObject);
  }
}
