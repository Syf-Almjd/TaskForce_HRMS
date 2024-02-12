class CheckoutModel {
  String dateTime;
  String userUID;
  String userLocationLatitude;
  String userLocationLongitude;
  String userPhoto;
  String userCity;
  String checkInTime;

  CheckoutModel(
      {required this.dateTime,
      required this.userLocationLatitude,
      required this.userLocationLongitude,
      required this.userPhoto,
      required this.userCity,
      required this.checkInTime,
      required this.userUID});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      checkInTime: json['checkInTime'],
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
      'checkInTime': checkInTime,
      'dateTime': dateTime,
      'userUID': userUID,
      'userLocationLongitude': userLocationLongitude,
      'userLocationLatitude': userLocationLatitude,
      'userPhoto': userPhoto,
      'userCity': userCity,
    };
  }
}
