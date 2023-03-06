import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/extend_user_informs/allowed_extersion_methods.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class AllowedExtensionsUsecase
    implements BaseUseCase<int, AllowedExtersionMethods> {
  final Repository _repository;
  AllowedExtensionsUsecase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, AllowedExtersionMethods>> execute(
      int profileId) async {
    return await _repository.getAllowedExtensions(profileId);
  }
}
