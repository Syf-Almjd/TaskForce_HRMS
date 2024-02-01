class EleaveModel {
  String dateTime;
  String userUID;
  String userLocationLatitude;
  String userLocationLongitude;
  String userPhoto;
  String userName;
  String requestInfo;
  String userCity;

  EleaveModel(
      {required this.dateTime,
      required this.userLocationLatitude,
      required this.userLocationLongitude,
      required this.userPhoto,
      required this.requestInfo,
      required this.userName,
      required this.userCity,
      required this.userUID});

  factory EleaveModel.fromJson(Map<String, dynamic> json) {
    return EleaveModel(
      dateTime: json['dateTime'],
      userUID: json['userUID'],
      requestInfo: json['requestInfo'],
      userLocationLongitude: json['userLocationLongitude'],
      userLocationLatitude: json['userLocationLatitude'],
      userPhoto: json['userPhoto'],
      userName: json['userName'],
      userCity: json['userCity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime,
      'userUID': userUID,
      'requestInfo': requestInfo,
      'userLocationLongitude': userLocationLongitude,
      'userLocationLatitude': userLocationLatitude,
      'userPhoto': userPhoto,
      'userName': userName,
      'userCity': userCity,
    };
  }
}
