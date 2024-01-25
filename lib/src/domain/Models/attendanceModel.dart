class AttendanceModel {
  String dateTime;
  String userUID;
  String userLocationLatitude;
  String userLocationLongitude;
  String userPhoto;
  String userCity;

  AttendanceModel(
      {required this.dateTime,
      required this.userLocationLatitude,
      required this.userLocationLongitude,
      required this.userPhoto,
      required this.userCity,
      required this.userUID});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      dateTime: json['dateTime'],
      userUID: json['userUID'],
      userLocationLongitude: json['userLocationLongitude'],
      userLocationLatitude: json['userLocationLatitude'],
      userPhoto: json['userPhoto'],
      userCity: json['userCity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'userUID': userUID,
      'userLocationLongitude': userLocationLongitude,
      'userLocationLatitude': userLocationLatitude,
      'userPhoto': userPhoto,
      'userCity': userCity,
    };
  }
}
