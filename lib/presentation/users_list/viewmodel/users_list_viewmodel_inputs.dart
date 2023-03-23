// inputs mean that "Orders" that our view model will receive from view
abstract class UsersListViewModelInputs {
  getUsersListData();
  getUsersListForPull([void Function()? dashboardRequestsStart]);
  Future getNextUsersList();
  Future getUserFromSearch();
  Future refreshUsersList();
  Future getParentList();
  Future getProfileList();
  setSearchInput(String searchInput);
  Sink get inputUsersListData;
  Sink get inputSearch;
  Sink get inputUsersList;
  Sink get inputParentList;
  Sink get inputStatusList;
  Sink get inputConnectionList;
  Sink get inputProfileList;
}
