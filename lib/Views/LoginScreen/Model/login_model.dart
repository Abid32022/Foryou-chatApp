class logInModel {
  String? status;
  UserData? userData;
  String? accessToken;
  String? tokenType;

  logInModel({this.status, this.userData, this.accessToken, this.tokenType});

  logInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class UserData {
  int? id;
  dynamic image;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? gender;
  String? birthday;
  String? location;
  dynamic provider;
  dynamic providerId;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.image,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.gender,
        this.birthday,
        this.location,
        this.provider,
        this.providerId,
        this.fcmToken,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    birthday = json['birthday'];
    location = json['location'];
    provider = json['provider'];
    providerId = json['provider_id'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['location'] = this.location;
    data['provider'] = this.provider;
    data['provider_id'] = this.providerId;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
