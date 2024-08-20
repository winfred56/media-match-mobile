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
      dateSearched: json['date_searched'],
      durationSeconds: json['duration_seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'date_searched': dateSearched,
      'duration_seconds': durationSeconds,
    };
  }
}
