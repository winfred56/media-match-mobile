class AudioSearchResponse {
  final String id;
  final String fileName;
  final double durationSeconds;

  AudioSearchResponse({
    required this.id,
    required this.fileName,
    required this.durationSeconds,
  });

  factory AudioSearchResponse.fromJson(Map<String, dynamic> json) {
    return AudioSearchResponse(
      id: json['id'],
      fileName: json['file_name'],
      durationSeconds: json['duration_seconds'],
    );
  }
}
