import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_media.dart';

class SharedPreferencesHelper {
  static const String audioSearchResponseListKey = 'audioSearchResponseList';

  static Future<void> addAudioSearchResponse(LocalMedia response) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        prefs.getStringList(audioSearchResponseListKey) ?? [];
    jsonList.add(jsonEncode(response.toJson()));
    await prefs.setStringList(audioSearchResponseListKey, jsonList);
  }

  static Future<List<LocalMedia>> getAudioSearchResponseList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        prefs.getStringList(audioSearchResponseListKey) ?? [];
    return jsonList.map((jsonString) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LocalMedia.fromJson(jsonMap);
    }).toList();
  }
}
