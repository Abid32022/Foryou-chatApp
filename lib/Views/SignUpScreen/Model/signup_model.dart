class SignUpModel {
  String? status;
  UserData? userData;
  String? accessToken;
  String? tokenType;

  SignUpModel({this.status, this.userData, this.accessToken, this.tokenType});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? gender;
  String? birthday;
  String? location;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserData(
      {this.name,
        this.email,
        this.gender,
        this.birthday,
        this.location,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    birthday = json['birthday'];
    location = json['location'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['location'] = this.location;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
