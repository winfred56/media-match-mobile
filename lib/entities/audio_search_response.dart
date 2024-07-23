class AudioSearchResponse {
  final int id;
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


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'duration_seconds': durationSeconds,
    };
  }
}
