import 'package:dartz/dartz.dart';
import 'package:sasuki/data/network/models/failure.dart';
import 'package:sasuki/domain/models/manager_journal/manager_journal.dart';
import 'package:sasuki/domain/repository/repository.dart';
import 'package:sasuki/domain/usecase/base_usecase.dart';
import 'package:sasuki/presentation/common/freezed_data_classes.dart';

class ManagerJournalUsecase
    implements BaseUseCase<ManagerJournalRequestObject, ManagerJournal> {
  final Repository _repository;
  ManagerJournalUsecase(this._repository);
  @override
  Future<Either<Failure, ManagerJournal>> execute(
    ManagerJournalRequestObject managerJournalRequestObject,
  ) async {
    return await _repository.getManagerJournal(managerJournalRequestObject);
  }
}
