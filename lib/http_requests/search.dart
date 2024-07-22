import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/audio_search_response.dart';

Future<AudioSearchResponse> search(String filePath) async {
  try {
    var url = Uri.parse('https://media-match-backend.onrender.com/find/');
    var request = http.MultipartRequest('GET', url);

    /// Add audio file to the request
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    /// Send the request
    var response = await request.send();

    /// Check the response status
    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = jsonDecode(responseData.body);
      return AudioSearchResponse.fromJson(data['file']);
    } else {
      print('Failed to upload audio file. Status code: ${response.statusCode}');
      throw Exception('Something went wrong');
    }
  } catch (e) {
    print('Error finding audio file: $e');
    throw Exception('Something went wrong');
  }
}
