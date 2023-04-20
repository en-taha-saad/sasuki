import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_details/manager_details.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ManagerDetailsUseCase implements BaseUseCase<int, ManagerDetails> {
  final Repository _repository;
  ManagerDetailsUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerDetails>> execute(int managerId) async {
    return await _repository.getManagerDetails(managerId);
  }
}
