// import 'dart:io';
// import 'package:http/http.dart' as http;
//
// Future<void> search(String filePath) async {
//   try {
//     print('@@@@@@@@@@@@@@');
//     var url = Uri.parse('https://media-match-backend.onrender.com/add/');
//     var request = http.MultipartRequest('POST', url);
//
//     // Add audio file to the request
//     request.files.add(await http.MultipartFile.fromPath('file', filePath));
//
//     // Send the request
//     var response = await request.send();
//
//     // Check the response status
//     if (response.statusCode == 200) {
//       print('Audio file uploaded successfully');
//     } else {
//       print('Failed to upload audio file. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error uploading audio file: $e');
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<void> search(String filePath) async {
  final uri = Uri.parse('https://media-match-backend.onrender.com/find/');
  final request = http.MultipartRequest('GET', uri);

  // Add the file to the request
  final file = File(filePath);
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = jsonDecode(responseData.body);
      print('Search result: $data');
    } else {
      print('Failed to search, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during search: $e');
  }
}