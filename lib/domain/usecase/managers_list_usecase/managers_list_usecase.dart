import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/managers_list/managers_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ManagersListUsecase implements BaseUseCase<Void, ManagersList> {
  final Repository _repository;
  ManagersListUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagersList>> execute(Void) async {
    return await _repository.getManagersList();
  }
}
