class ChangeProfileRequest {
  String? userId;
  int? profileId;
  String? changeType;

  ChangeProfileRequest(this.userId, this.profileId, this.changeType);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['profile_id'] = profileId;
    data['change_type'] = changeType;
    return data;
  }
}
