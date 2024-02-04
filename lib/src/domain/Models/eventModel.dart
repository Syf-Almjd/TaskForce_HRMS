class EventModel {
  String date;
  String title;
  String description;
  String locationName;
  String locationLongitude;
  String locationLatitude;
  String image;
  String datePublished;

  EventModel({
    required this.date,
    required this.title,
    required this.description,
    required this.locationName,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.image,
    required this.datePublished,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      date: json['date'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      locationName: json['locationName'] as String,
      image: json['image'] as String,
      locationLatitude: json["locationLatitude"],
      locationLongitude: json["locationLongitude"],
      datePublished: json["datePublished"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'description': description,
      'locationName': locationName,
      'locationLongitude': locationLongitude,
      'locationLatitude': locationLatitude,
      'image': image,
      'datePublished': datePublished,
    };
  }
}
