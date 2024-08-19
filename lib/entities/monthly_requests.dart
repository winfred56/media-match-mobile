class MonthlyRequests {
  int january;
  int february;
  int march;
  int april;
  int may;
  int june;
  int july;
  int august;
  int september;
  int october;
  int november;
  int december;

  MonthlyRequests({
    this.january = 0,
    this.february = 0,
    this.march = 0,
    this.april = 0,
    this.may = 0,
    this.june = 0,
    this.july = 0,
    this.august = 0,
    this.september = 0,
    this.october = 0,
    this.november = 0,
    this.december = 0,
  });

  /// Convert a MonthlyRequests object to JSON
  Map<String, dynamic> toJson() {
    return {
      'January': january,
      'February': february,
      'March': march,
      'April': april,
      'May': may,
      'June': june,
      'July': july,
      'August': august,
      'September': september,
      'October': october,
      'November': november,
      'December': december,
    };
  }

  /// Create a MonthlyRequests object from JSON
  factory MonthlyRequests.fromJson(Map<String, dynamic> json) {
    return MonthlyRequests(
      january: json['January'] ?? 0,
      february: json['February'] ?? 0,
      march: json['March'] ?? 0,
      april: json['April'] ?? 0,
      may: json['May'] ?? 0,
      june: json['June'] ?? 0,
      july: json['July'] ?? 0,
      august: json['August'] ?? 0,
      september: json['September'] ?? 0,
      october: json['October'] ?? 0,
      november: json['November'] ?? 0,
      december: json['December'] ?? 0,
    );
  }
}
