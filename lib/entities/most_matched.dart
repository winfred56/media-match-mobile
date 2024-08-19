class MostMatched {
  final String fileName;
  final int matchCount;

  MostMatched({
    required this.fileName,
    required this.matchCount,
  });

  /// Factory constructor to create a FileMatch from a JSON map
  factory MostMatched.fromJson(Map<String, dynamic> json) {
    return MostMatched(
      fileName: json['file_name'],
      matchCount: json['match_count'],
    );
  }

  /// Method to convert a FileMatch instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'match_count': matchCount,
    };
  }
}
