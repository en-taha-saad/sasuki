abstract class UserDetailsViewModelInputs {
  getUserApiOverview(int userId);
  deleteUser(context);
  renameUsername(String newUsername);
  changeProfile(int profileId);
  depositAction(String amount, String comment);
  withdrawAction(String amount, String comment);
  payDebtAction(String amount, String comment);
  getUserDataStreamingly();
  getPayDebtInforms();
  Future getProfileList();
  Sink get inputUserApiOverview;
  Sink get inputProfileList;
}
