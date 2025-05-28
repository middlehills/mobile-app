class MidhillUser {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String pin;
  final bool suspended;
  final bool deleted;
  final bool verified;
  final DateTime updatedAt;
  final DateTime createdAt;

  MidhillUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.pin,
    required this.suspended,
    required this.deleted,
    required this.verified,
    required this.updatedAt,
    required this.createdAt,
  });

  factory MidhillUser.fromJson(Map<String, dynamic> json) {
    return MidhillUser(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      pin: json['pin'] as String,
      suspended: json['suspended'] as bool,
      deleted: json['deleted'] as bool,
      verified: json['verified'] as bool,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
