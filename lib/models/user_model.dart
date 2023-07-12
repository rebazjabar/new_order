// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

UserModel temperaturesFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String temperaturesToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  NewUser? user;
  Role? role;
  String? token;

  UserModel({
    this.user,
    this.role,
    this.token,
  });

  UserModel copyWith({
    NewUser? user,
    Role? role,
    String? token,
  }) =>
      UserModel(
        user: user ?? this.user,
        role: role ?? this.role,
        token: token ?? this.token,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["user"] == null ? null : NewUser.fromJson(json["user"]),
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "role": role?.toJson(),
        "token": token,
      };
}

class Role {
  String? name;
  List<String>? permissions;

  Role({
    this.name,
    this.permissions,
  });

  Role copyWith({
    String? name,
    List<String>? permissions,
  }) =>
      Role(
        name: name ?? this.name,
        permissions: permissions ?? this.permissions,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
        permissions: json["permissions"] == null
            ? []
            : List<String>.from(json["permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
      };
}

class NewUser {
  int? id;
  String? firstName;
  String? lastName;
  String? city;
  String? name;
  String? mobileCode;
  String? mobileNumber;
  String? password;
  String? passwordConfirmation;
  String? email;
  String? photoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewUser({
    this.id,
    this.firstName,
    this.lastName,
    this.city,
    this.name,
    this.mobileCode,
    this.mobileNumber,
    this.password,
    this.passwordConfirmation,
    this.email,
    this.photoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) => NewUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        city: json["city"],
        name: json["name"],
        mobileCode: json["mobile_code"],
        mobileNumber: json["mobile_number"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        email: json["email"],
        photoUrl: json["photo_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "city": city,
        "name": name,
        "mobile_code": mobileCode,
        "mobile_number": mobileNumber,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "email": email,
        "photo_url": photoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
