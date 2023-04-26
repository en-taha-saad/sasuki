import 'package:sasuki/app/extensions/non_null_int.dart';
import 'package:sasuki/app/extensions/non_null_string.dart';
import 'package:sasuki/data/responses/manager_journal_responses/manager_journal_responses.dart';
import 'package:sasuki/domain/models/manager_journal/manager_journal.dart';

extension ManagerJournalResponsesMapper on ManagerJournalResponses? {
  ManagerJournal toDomain() {
    return ManagerJournal(
      this?.data?.map((e) => e.toDomain()).toList(),
      this?.total.orZero(),
    );
  }
}

extension ManagerJournalDataResponseMapper on ManagerJournalDataResponse? {
  ManagerJournalData toDomain() {
    return ManagerJournalData(
      this?.id.orZero(),
      this?.amount.orEmpty(),
      this?.createdAt.orEmpty(),
      this?.description.orEmpty(),
      this?.comment.orEmpty(),
      this?.balance.orEmpty(),
      this?.credit.orEmpty(),
      this?.debt.orEmpty(),
      this?.operation.orEmpty(),
    );
  }
}
