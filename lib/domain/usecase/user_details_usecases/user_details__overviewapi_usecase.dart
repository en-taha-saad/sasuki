import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/user_details/user_overview_api.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class UserOverviewApiUseCase implements BaseUseCase<int, UserOverviewApi> {
  final Repository _repository;
  UserOverviewApiUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, UserOverviewApi>> execute(int userId) async {
    return await _repository.getUserOverviewApi(userId);
  }
}
