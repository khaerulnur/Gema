import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? createdAt;
  String? email;
  String? firstName;
  String? lastName;
  String? noHp;

  UserModel(
      {this.createdAt, this.email, this.firstName, this.lastName, this.noHp});

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    noHp = json['noHp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['noHp'] = this.noHp;
    return data;
  }
}
