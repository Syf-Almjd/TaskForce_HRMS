import 'dart:convert';

class UserModel {
  String userID;
  String name;
  String email;
  String password;
  String photoID;
  String address;
  String phoneNumber;
  String points;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
    required this.photoID,
    required this.address,
    required this.phoneNumber,
    required this.points,
  });

  // Convert UserModel object to a map that can be serialized to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'photoID': photoID,
      'email': email,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
      'points': points,

    };
  }

  // Create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      photoID: json['photoID'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      points: json['points'],
    );
  }

  // Convert the UserModel object to a JSON string
  String toJsonString() {
    Map<String, dynamic> jsonMap = toJson();
    return jsonEncode(jsonMap);
  }

  // Create a UserModel object from a JSON string
  factory UserModel.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }
}
