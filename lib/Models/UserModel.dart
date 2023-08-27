import 'dart:convert';

class UserModel {
  String userID;
  String name;
  String email;
  String password;
  String photoID;
  String lastLogin;
  String phoneNumber;
  String address;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.password,
    required this.photoID,
    required this.lastLogin,
    required this.phoneNumber,
    required this.address,
  });

  // Convert UserModel object to a MAP that can be serialized to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'photoID': photoID,
      'email': email,
      'password': password,
      'lastLogin': lastLogin,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.empty() {
    return UserModel(
        userID: "userID",
        name: "name",
        email: "email",
        password: "password",
        photoID: "photoID",
        lastLogin: "lastLogin",
        phoneNumber: "phoneNumber",
        address: "address");
  }

  /// Create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      photoID: json['photoID'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      lastLogin: json['lastLogin'],
    );
  }

  /// Convert the UserModel object to a JSON string
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
