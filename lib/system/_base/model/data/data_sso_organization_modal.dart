import 'package:object_mapper/object_mapper.dart';

class DataSSOOrganizationModal with Mappable {
  DataSSOOrganizationModal({
    this.organizationId,
    this.name,
    this.order,
    this.code,
    this.listUser,
  });

  String? organizationId;
  String? name;
  int? order;
  String? code;
  String? view;

  List<OrganizationsUserModel>? listUser;

  @override
  void mapping(Mapper map) {
    map("organizationId", organizationId, (v) => organizationId = v);
    map("name", name, (v) => name = v);
    map("order", order, (v) => order = v);
    map("code", code, (v) => code = v);
    map<OrganizationsUserModel>("listUser", listUser, (v) => listUser = v);
  }

  factory DataSSOOrganizationModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataSSOOrganizationModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataSSOOrganizationModal>();
    return obj ?? DataSSOOrganizationModal();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

class OrganizationsUserModel with Mappable {
  OrganizationsUserModel(
      {this.key,
      this.fullName,
      this.info,
      this.emailAddress,
      this.title,
      this.code,
      this.type});
  String? key;
  String? fullName;
  String? info;
  String? emailAddress;
  String? title;
  String? code;
  String? type;

  @override
  void mapping(Mapper map) {
    map("key", key, (v) => key = v);
    map("info", info, (v) => info = v);
    map("emailAddress", emailAddress, (v) => emailAddress = v);
    map("title", title, (v) => title = v);
    map("code", code, (v) => code = v);
    map("type", type, (v) => type = v);
    map("name", fullName, (v) => fullName = v);
  }

  factory OrganizationsUserModel.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return OrganizationsUserModel();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<OrganizationsUserModel>();
    return obj ?? OrganizationsUserModel();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}

class DataSSOOrganizationModalClient with Mappable {
  DataSSOOrganizationModalClient({
    this.organizationId,
    this.name,
    this.order,
    this.code,
    this.listUser,
  });

  String? organizationId;
  String? name;
  int? order;
  String? code;
  String? view;

  List<OrganizationsUserModel>? listUser;

  @override
  void mapping(Mapper map) {
    map("organizationId", organizationId, (v) => organizationId = v);
    map("name", name, (v) => name = v);
    map("order", order, (v) => order = v);
    map("code", code, (v) => code = v);
    map<OrganizationsUserModel>("listUser", listUser, (v) => listUser = v);
  }

  factory DataSSOOrganizationModalClient.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataSSOOrganizationModalClient();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataSSOOrganizationModalClient>();
    return obj ?? DataSSOOrganizationModalClient();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }
}
