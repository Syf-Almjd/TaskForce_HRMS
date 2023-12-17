class EventModel {
  String date;
  String title;
  String description;
  String location;
  String image;

  EventModel({
    required this.date,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      date: json['date'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
    };
  }
}
