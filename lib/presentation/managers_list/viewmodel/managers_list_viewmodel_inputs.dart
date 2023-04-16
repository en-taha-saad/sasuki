// inputs mean that "Orders" that our view model will receive from view
abstract class ManagersListViewModelInputs {
  getManagersListData();
  getManagersListForPull();
  Future getNextManagersList();
  Future getManagerFromSearch();
  Future refreshManagersList();
  Future getParentList();
  Future getProfileList();
  setSearchInput(String searchInput);
  Sink get inputManagersListData;
  Sink get inputSearch;
  Sink get inputManagersList;
  Sink get inputParentList;
  Sink get inputStatusList;
  Sink get inputConnectionList;
  Sink get inputProfileList;
}
