import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/filter_lists/profile_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ProfileListUseCase implements BaseUseCase<void, ProfileList> {
  final Repository _repository;
  ProfileListUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, ProfileList>> execute(void input) async {
    return await _repository.getProfileList();
  }
}
