// inputs mean that "Orders" that our view model will receive from view
abstract class ManagersListViewModelInputs {
  getManagersListData();
  getManagersListForPull();
  Future getNextManagersList();
  Future getManagerFromSearch();
  Future refreshManagersList();
  Future getParentManagerList();
  Future getAclPermissionGroupList();
  setSearchInput(String searchInput);
  Sink get inputManagersListData;
  Sink get inputSearch;
  Sink get inputManagersList;
  Sink get inputAclPermissionGroupList;
  Sink get inputParentManagerList;
}
