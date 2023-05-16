class ActivationsReports {
  List<Activation>? data;
  int? total;

  ActivationsReports(this.data, this.total);
}

class Activation {
  int? id;
  String? price;
  String? createdAt;
  UserDetails? userDetails;
  ManagerDetails? managerDetails;
  ProfileDetails? profileDetails;
  String oldExpiration;
  String newExpiration;
  String activationMethod;
  int userActivationsCount;
  int? refunded;

  Activation(
    this.id,
    this.price,
    this.createdAt,
    this.userDetails,
    this.managerDetails,
    this.profileDetails,
    this.oldExpiration,
    this.newExpiration,
    this.activationMethod,
    this.userActivationsCount,
    this.refunded,
  );
}

class UserDetails {
  int? id;
  String? username;
  String? firstname;
  String? lastname;

  UserDetails(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
  );
}

class ManagerDetails {
  int? id;
  String? username;

  ManagerDetails(
    this.id,
    this.username,
  );
}

class ProfileDetails {
  int? id;
  String? name;

  ProfileDetails(
    this.id,
    this.name,
  );
}
