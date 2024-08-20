class LocalMedia {
  final int id;
  final String fileName;
  final DateTime dateSearched;
  final double durationSeconds;

  LocalMedia({
    required this.id,
    required this.fileName,
    required this.dateSearched,
    required this.durationSeconds,
  });

  factory LocalMedia.fromJson(Map<String, dynamic> json) {
    return LocalMedia(
      id: json['id'],
      fileName: json['file_name'],
      durationSeconds: json['duration_seconds'],
      dateSearched: DateTime.parse(json['date_searched']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'duration_seconds': durationSeconds,
      'date_searched': dateSearched.toIso8601String(),
    };
  }
}
