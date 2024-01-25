import 'dart:convert'; // Add this import for json.decode

import 'package:http/http.dart' as http;

class HttpRequestPage {
  static Future<Map?> getCityInfoAPI(latitude, longitude) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$latitude&longitude=$longitude");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body); // Use jsonDecode to parse JSON
      return Map<String, dynamic>.from(json);
    }
    return {};
  }
}
