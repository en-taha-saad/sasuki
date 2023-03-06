import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/dashboard/dashboard.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class DashboardUseCase implements BaseUseCase<void, Dashboard> {
  final Repository _repository;
  DashboardUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, Dashboard>> execute(void input) async {
    return await _repository.getDashboardData();
  }
}
