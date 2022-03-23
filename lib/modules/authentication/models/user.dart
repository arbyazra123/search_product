// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.username,
        this.password,
        this.email,
        this.name,
        this.phone,
    });

    String? username;
    String? password;
    String? email;
    String? name;
    String? phone;

    UserModel copyWith({
        String? username,
        String? password,
        String? email,
        String? name,
        String? phone,
    }) => 
        UserModel(
            username: username ?? this.username,
            password: password ?? this.password,
            email: email ?? this.email,
            name: name ?? this.name,
            phone: phone ?? this.phone,
        );

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        name: json["name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "name": name,
        "phone": phone,
    };
}
