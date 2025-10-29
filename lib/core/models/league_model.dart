class League {
  final int id;
  final String shortName;
  final String name;
  final String country;
  late final String logoUrl;
  final DateTime expectedStartDate;

  League({
    required this.id,
    required this.shortName,
    required this.name,
    required this.country,
    required this.logoUrl,
    required this.expectedStartDate,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'] as int,
      shortName: json['shortName'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      logoUrl: (json['logoUrl'] ?? '').replaceAll(r'\/', '/'),
      expectedStartDate: DateTime.parse(json['expectedStartDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shortName': shortName,
      'name': name,
      'country': country,
      'logoUrl': logoUrl,
      'expectedStartDate': expectedStartDate.toIso8601String(),
    };
  }
}