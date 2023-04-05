abstract class AddUserViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  setFirstName(String firstName);
  setLastName(String lastName);
  setPhone(String phone);
  setNotes(String notes);
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
  Future getProfileList();
  Future getParentList();

  Sink get inputProfileList;
  Sink get inputParentList;

  addUser();
}
