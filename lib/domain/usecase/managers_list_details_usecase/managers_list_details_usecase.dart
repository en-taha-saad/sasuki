import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_list_details/manager_list_details.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ManagersListDetailsUsecase
    implements BaseUseCase<ManagersListRequestObject, ManagerListDetails> {
  final Repository _repository;
  ManagersListDetailsUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ManagerListDetails>> execute(
      ManagersListRequestObject managersListRequestObject) async {
    return await _repository.getManagersListDetails(managersListRequestObject);
  }
}
