class AccountModel {
  String? userName;
  String? password;

  AccountModel({
    this.userName,
    this.password,
  });

  Map<String, dynamic> toMap() {
    // ignore: prefer_collection_literals, unnecessary_new
    var map = new Map<String, dynamic>();
    map["userName"] = userName;
    map["password"] = password;

    return map;
  }
}