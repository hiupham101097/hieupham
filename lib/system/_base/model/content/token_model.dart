class TokenModel {
  final String accessToken;
  final int? expireInSeconds;
  final String? encryptedAccessToken;
  final int? userId;
  final int? tenantId;

  TokenModel(
    this.accessToken, {
    this.expireInSeconds,
    this.encryptedAccessToken,
    this.tenantId,
    this.userId,
  });

  factory TokenModel.fromJson(
    Map<String, dynamic> jsonInput,
  ) {
    return TokenModel(
      jsonInput["accessToken"],
      expireInSeconds: jsonInput["expireInSeconds"],
      encryptedAccessToken: jsonInput["encryptedAccessToken"],
      tenantId: jsonInput["tenantId"],
      userId: jsonInput["userId"],
    );
  }
}
