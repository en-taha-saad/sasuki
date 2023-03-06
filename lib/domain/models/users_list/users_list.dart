class UsersList {
  // int currentPage;
  List<UsersListData>? data;
  // String firstPageUrl;
  // int from;
  // int lastPage;
  // String lastPageUrl;
  // String nextPageUrl;
  // String path;
  // int perPage;
  // int to;
  int total;

  UsersList(
    // this.currentPage,
    this.data,
    // this.firstPageUrl,
    // this.from,
    // this.lastPage,
    // this.lastPageUrl,
    // this.nextPageUrl,
    // this.path,
    // this.perPage,
    // this.to,
    this.total,
  );
}

class UsersListData {
  int id;
  String username;
  String firstname;
  String lastname;
  // String city;
  // String phone;
  // int profileId;
  // String balance;
  String expiration;
  // int parentId;
  int enabled;
  String notes;
  // int simultaneousSessions;
  // String address;
  // String contractId;
  // String createdAt;
  // int groupId;
  // int nRow;
  Status? status;
  int onlineStatus;
  // String parentUsername;
  ProfileDetails? profileDetails;
  // GroupDetails? groupDetails;

  UsersListData(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    // this.city,
    // this.phone,
    // this.profileId,
    // this.balance,
    this.expiration,
    // this.parentId,
    this.enabled,
    this.notes,
    // this.simultaneousSessions,
    // this.address,
    // this.contractId,
    // this.createdAt,
    // this.groupId,
    // this.nRow,
    this.status,
    this.onlineStatus,
    // this.parentUsername,
    this.profileDetails,
    // this.groupDetails,
  );
}

class Status {
  bool status;
  // bool traffic;
  // bool expiration;
  // bool uptime;

  Status(
    this.status,
    // this.traffic,
    // this.expiration,
    // this.uptime,
  );
}

class ProfileDetails {
  int id;
  String name;
  int type;

  ProfileDetails(
    this.id,
    this.name,
    this.type,
  );
}

class GroupDetails {
  int id;
  String groupName;

  GroupDetails(
    this.id,
    this.groupName,
  );
}
