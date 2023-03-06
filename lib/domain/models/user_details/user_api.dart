class UserApi {
  UserData? data;
  int? status;

  UserApi(this.data, this.status);
}

class UserData {
  int? id;
  String? username;
  int? profileId;
  int? enabled;
  String? expiration;
  String? address;
  String? city;
  String? country;
  int? macAuth;
  String? staticIp;
  int? groupId;
  String? service;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? company;
  String? apartment;
  String? street;
  int? contractId;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? lastIpAddress;
  String? lastOnline;
  int? userType;
  String? createdBy;
  int? nationalId;
  int? simultaneousSessions;
  String? mikrotikWinboxGroup;
  String? mikrotikFramedRoute;
  String? mikrotikAddresslist;
  String? mikrotikIpv6Prefix;
  String? balance;
  String? loanBalance;
  String? notes;
  String? picture;
  int? pinTries;
  int? siteId;
  String? gpsLat;
  String? gpsLng;
  int? lastProfileId;
  int? autoRenew;
  int? useSeparatePortalPassword;
  int? restricted;
  String? profileName;
  UserDataStatus? status;
  bool? profileChange;
  String? parentUsername;

  UserData(
    this.id,
    this.username,
    this.profileId,
    this.enabled,
    this.expiration,
    this.address,
    this.city,
    this.country,
    this.macAuth,
    this.staticIp,
    this.groupId,
    this.service,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.company,
    this.apartment,
    this.street,
    this.contractId,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lastIpAddress,
    this.lastOnline,
    this.userType,
    this.createdBy,
    this.nationalId,
    this.simultaneousSessions,
    this.mikrotikWinboxGroup,
    this.mikrotikFramedRoute,
    this.mikrotikAddresslist,
    this.mikrotikIpv6Prefix,
    this.balance,
    this.loanBalance,
    this.notes,
    this.picture,
    this.pinTries,
    this.siteId,
    this.gpsLat,
    this.gpsLng,
    this.lastProfileId,
    this.autoRenew,
    this.useSeparatePortalPassword,
    this.restricted,
    this.profileName,
    this.status,
    this.profileChange,
    this.parentUsername,
  );
}

class UserDataStatus {
  bool? status;
  bool? traffic;
  bool? expiration;
  bool? uptime;

  UserDataStatus(
    this.status,
    this.traffic,
    this.expiration,
    this.uptime,
  );
}
