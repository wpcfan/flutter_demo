class Auth {
  final String sessionToken;
  final String objectId;
  final DateTime createdAt;

  Auth(this.sessionToken, this.objectId, this.createdAt);

  Auth.fromJson(Map<String, dynamic> json)
      : sessionToken = json['sessionToken'],
        objectId = json['objectId'],
        createdAt = DateTime.parse(json['createdAt']);

  Map<String, dynamic> toJson() => {
        'sessionToken': sessionToken,
        'objectId': objectId,
        'createdAt': createdAt.toIso8601String(),
      };
}
