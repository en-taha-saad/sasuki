import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/filter_lists/parent_list.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';

class ParentListUseCase implements BaseUseCase<void, List<SingleParentData>> {
  final Repository _repository;
  ParentListUseCase(this._repository);
  @override
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<Either<Failure, List<SingleParentData>>> execute(void input) async {
    return await _repository.getParentList();
  }
}
