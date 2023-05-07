// inputs mean that "Orders" that our view model will receive from view
abstract class ActivityLogViewModelViewModelInputs {
  getActivityLogListData();
  getActivityLogListDataForPull();
  Future getNextActivityLogListData();
  Future getActivityLogFromSearch();
  Future refreshActivityLogListData();
  Future getActivityLogEvents();
  setSearchInput(String searchInput);

  Sink get inputActivityLogListData;
  Sink get inputSearch;
  Sink get inputActivityLogEvents;
}
