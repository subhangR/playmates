
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExternalApiService {

  Future<void> postObjectAsJson(dynamic object, String url) async {
    // Convert the object to a JSON string
    String jsonString = jsonEncode(object);

    // Send the POST request with the JSON data
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonString,
    );

    // Check the response status and handle errors if needed
    if (response.statusCode == 200) {
      print('POST request successful. Response: ${response.body}');
    } else {
      print('POST request failed. Status code: ${response.statusCode}');
    }
  }
}