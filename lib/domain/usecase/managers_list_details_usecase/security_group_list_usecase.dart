import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_list_details/security_group.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class SecurityGroupListUseCase implements BaseUseCase<void, SecurityGroup> {
  final Repository _repository;
  SecurityGroupListUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, SecurityGroup>> execute(void input) async {
    return await _repository.getSecurityGroupList();
  }
}
