class ProfileModel {
  ProfileMode? profile;

  ProfileModel({this.profile});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new ProfileMode.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class ProfileMode {
  int? id;
  String? image;
  String? name;
  String? email;
  String? gender;
  String? birthday;
  String? location;

  ProfileMode(
      {this.id,
        this.image,
        this.name,
        this.email,
        this.gender,
        this.birthday,
        this.location});

  ProfileMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    birthday = json['birthday'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['location'] = this.location;
    return data;
  }
}
