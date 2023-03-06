import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/users_list/users_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class UsersListUseCase implements BaseUseCase<UserRequestObject, UsersList> {
  final Repository _repository;
  UsersListUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, UsersList>> execute(UserRequestObject userRequest) async {
    return await _repository.getUsersList(userRequest);
  }
}
