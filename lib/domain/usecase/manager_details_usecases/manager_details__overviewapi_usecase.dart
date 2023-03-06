import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_details/manager_overview_api.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ManagerOverviewApiUseCase
    implements BaseUseCase<int, ManagerOverviewApi> {
  final Repository _repository;
  ManagerOverviewApiUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerOverviewApi>> execute(int managerId) async {
    return await _repository.getManagerOverviewApi(managerId);
  }
}
