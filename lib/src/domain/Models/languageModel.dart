class LanguageModel {
  String nameCode;
  String flag;
  String countryCode;

  // Constructor
  LanguageModel(
      {required this.nameCode, required this.flag, required this.countryCode});

  // Factory constructor to create an instance from a Map
  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      nameCode: map['nameCode'],
      flag: map['flag'],
      countryCode: map['countryCode'],
    );
  }

  // Convert the object to a Map
  Map<String, dynamic> toMap() {
    return {
      'nameCode': nameCode,
      'flag': flag,
      'countryCode': countryCode,
    };
  }
}
