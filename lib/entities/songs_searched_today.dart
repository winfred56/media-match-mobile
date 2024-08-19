class SearchedToday {
  final int id;
  final String status;
  final String mediaName;
  final DateTime timestamp;

  SearchedToday({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.mediaName,
  });

  /// Factory constructor to create an TrendingToday from a JSON map
  factory SearchedToday.fromJson(Map<String, dynamic> json) {
    return SearchedToday(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      mediaName: json['data'],
    );
  }

  /// Method to convert an TrendingToday instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'data': mediaName,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
