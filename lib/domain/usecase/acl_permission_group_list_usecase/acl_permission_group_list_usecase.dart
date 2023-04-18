import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/acl_permission_group_list/acl_permission_group_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class AclPermissionGroupListUsecase
    implements BaseUseCase<void, AclPermissionGroupList> {
  final Repository _repository;
  AclPermissionGroupListUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, AclPermissionGroupList>> execute(Void) async {
    return await _repository.getAclPermissionGroupList();
  }
}
