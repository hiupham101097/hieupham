class ProfileModel {
  late int id;
  String? fullName;
  String? emailAddress;
  String? phoneNumber;
  String? address;

  ProfileModel(
    this.id, {
    this.fullName,
    this.emailAddress,
    this.phoneNumber,
    this.address,
  });

  Map<String, dynamic> toMap() {
    // ignore: prefer_collection_literals, unnecessary_new
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["fullName"] = fullName;
    map["emailAddress"] = emailAddress;
    map["phoneNumber"] = phoneNumber;

    return map;
  }
}
