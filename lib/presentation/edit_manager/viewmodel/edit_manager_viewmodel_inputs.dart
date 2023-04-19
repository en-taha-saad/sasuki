abstract class EditManagerViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  setFirstName(String firstName);
  setLastName(String lastName);
  setPhone(String phone);
  setNotes(String notes);
  setCompany(String company);
  setCity(String city);
  setAddress(String address);
  setEmail(String email);
  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputFirstName;
  Sink get inputLastName;

  Sink get inputAreAllInputsValid;
  Future getParentManagerList();
  Future getAclPermissionGroupList();

  Sink get inputAclPermissionGroupList;
  Sink get inputParentManagerList;

  editManager();
}
