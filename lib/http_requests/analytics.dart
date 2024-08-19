import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:media_match/entities/most_matched.dart';

import '../entities/monthly_requests.dart';
import '../entities/songs_searched_today.dart';

const String baseUrl = 'https://media-match-backend.onrender.com';

Future<MonthlyRequests> requestsPerMonth() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/requests-per-month/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return MonthlyRequests.fromJson(data);
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding audio file: $e');
    }
    throw Exception('Something went wrong');
  }
}

Future<int> totalRequestsThisYear() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/total-requests-current-year/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return data['total_requests'];
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding audio file: $e');
    }
    throw Exception('Something went wrong');
  }
}

Future<List<SearchedToday>> searchesMadeToday() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/find-requests-today/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print(data);
      }

      /// Extract the list from the response if it contains 'find_requests_today'
      final List<dynamic> searchRecords = data['find_requests_today'];

      /// Convert JSON to a list of SearchedToday
      List<SearchedToday> searchResponses = searchRecords
          .where((json) => json['status'] == 'successful')
          .map((json) => SearchedToday.fromJson(json))
          .toList();

      if (kDebugMode) {
        print(searchResponses);
      }

      return searchResponses;
    } else {
      if (kDebugMode) {
        print('Failed to fetch searches. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding searches: $e');
    }
    throw Exception('Something went wrong');
  }
}

Future<double> averageWeeklySearches() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/average-requests-per-week/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }
      return data['average_requests_per_week'];
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding audio file: $e');
    }
    throw Exception('Something went wrong');
  }
}

Future<List<MostMatched>> mostMatchedSongs() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/top-matched-audios/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }

      /// Extract the list from the response if it contains 'top_matched_audios'
      final List<dynamic> results = data['top_matched_audios'];

      /// Convert JSON to a list of SearchedToday
      List<MostMatched> searchResponses = results.isNotEmpty
          ? results.map((json) => MostMatched.fromJson(json)).toList()
          : [];

      if (kDebugMode) {
        print(searchResponses);
      }

      return searchResponses;
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding audio file: $e');
    }
    throw Exception('Something went wrong');
  }
}

Future<List<MostMatched>> mostMatchedVideos() async {
  try {
    final uri = Uri.parse('$baseUrl/analytics/top-matched-videos/');

    /// Make the request
    final response = await http.get(uri);

    /// Check the response status
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
      }

      /// Extract the list from the response if it contains 'top_matched_audios'
      final List<dynamic> results = data['top_matched_videos'];

      /// Convert JSON to a list of SearchedToday
      List<MostMatched> searchResponses = results.isNotEmpty
          ? results.map((json) => MostMatched.fromJson(json)).toList()
          : [];

      if (kDebugMode) {
        print(searchResponses);
      }

      return searchResponses;
    } else {
      if (kDebugMode) {
        print(
            'Failed to upload audio file. Status code: ${response.statusCode}');
      }
      throw Exception('Something went wrong');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error finding audio file: $e');
    }
    throw Exception('Something went wrong');
  }
}
