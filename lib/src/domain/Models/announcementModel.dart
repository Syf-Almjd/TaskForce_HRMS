class AnnouncementModel {
  String date;
  String title;
  String description;
  String image;

  AnnouncementModel({
    required this.date,
    required this.title,
    required this.description,
    required this.image,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      date: json['date'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'description': description,
      'image': image,
    };
  }
}
