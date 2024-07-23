import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'audio_search_response.dart';

class SharedPreferencesHelper {
  static const String audioSearchResponseListKey = 'audioSearchResponseList';

  static Future<void> addAudioSearchResponse(AudioSearchResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList(audioSearchResponseListKey) ?? [];
    jsonList.add(jsonEncode(response.toJson()));
    await prefs.setStringList(audioSearchResponseListKey, jsonList);
  }

  static Future<List<AudioSearchResponse>> getAudioSearchResponseList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = prefs.getStringList(audioSearchResponseListKey) ?? [];
    return jsonList.map((jsonString) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return AudioSearchResponse.fromJson(jsonMap);
    }).toList();
  }
}
