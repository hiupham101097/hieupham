import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:object_mapper/object_mapper.dart';

import '../../../_variables/value/key_value_model.dart';
import '../data/data_tenant_modal.dart';

// ignore: must_be_immutable
class UserDataModal extends Equatable with Mappable {
  late int? id;
  String? userName;
  String? fullName;
  String? emailAddress;
  String? phoneNumber;
  String? address;

  String? typeFamily;
  String? profiles;
  String? contacts;

  String? name;
  String? surname;
  bool isActive;
  bool isEmailConfirmed;
  String? eduRole;
  String? titleFamily;

  int? tenantId;
  DataTenantModal? tenant;
  List<DataTenantModal>? listTenant;

  List<KeyValueModal>? listInformation;

  UserDataModal(
    this.id,
    this.userName,
    this.fullName, {
    this.name,
    this.surname,
    this.emailAddress,
    this.phoneNumber,
    this.address,
    this.typeFamily,
    this.profiles,
    this.contacts,
    this.tenantId,
    this.tenant,
    this.listTenant,
    this.isActive = false,
    this.isEmailConfirmed = false,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("userName", userName, (v) => userName = v);
    map("name", name, (v) => name = v);
    map("surname", surname, (v) => surname = v);
    map("fullName", fullName, (v) => fullName = v);
    map("emailAddress", emailAddress, (v) => emailAddress = v);
    map("phoneNumber", phoneNumber, (v) => phoneNumber = v);
    map("typeFamily", typeFamily, (v) => typeFamily = v);
    map("profiles", profiles, (v) => profiles = v);
    map("contacts", contacts, (v) => contacts = v);
    map("tenantId", tenantId, (v) => tenantId = v);
    map("isActive", isActive, (v) => isActive = v);
    map("isEmailConfirmed", isEmailConfirmed, (v) => isEmailConfirmed = v);
    map("isActive", isActive, (v) => isActive = v);
    map<KeyValueModal>("listInformation", listInformation, (v) => listInformation = v);
    map<DataTenantModal>("tenant", tenant, (v) => tenant = v);
    map<DataTenantModal>("listTenant", listTenant, (v) => listTenant = v);
  }

  factory UserDataModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return UserDataModal(0, "", "");
    }

    var obj = Mapper.fromJson(jsonInput).toObject<UserDataModal>();
    if (obj != null) {
      if (obj.emailAddress == null || obj.emailAddress == "") {
        obj.emailAddress = jsonInput["details"] ?? "";
      }

      if (obj.tenant != null &&
          obj.listTenant != null &&
          // ignore: prefer_is_empty
          obj.listTenant!.length > 0) {
        obj.tenant = obj.listTenant!.firstWhere(
          (tenant) => tenant.id == obj.tenant!.id,
          // ignore: null_closures
          orElse: null,
        );
      }

      if (obj.profiles != null) {
        try {
          List<KeyValueModal> list = (jsonDecode(obj.profiles!) as Iterable)
              .map((item) => KeyValueModal.fromJson(item))
              .toList();
          var address = list.firstWhere((item) => item.key == "ADDRESS");
          obj.address = address.value ?? "";
          // ignore: empty_catches
        } catch (e) {}
      } else {
        obj.address = "";
      }
    }

    return obj ?? UserDataModal(0, "", "");
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    var map = this.toJson();

    List<KeyValueModal> list = [
      KeyValueModal(key: "ADDRESS", value: address ?? "")
    ];

    map["profiles"] = jsonEncode(list.map((item) => item.toMap()).toList());

    return map;
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        fullName,
        name,
        surname,
        emailAddress,
        phoneNumber,
        address,
        typeFamily,
        profiles,
        contacts,
        eduRole,
        titleFamily,
        tenantId,
        isActive,
        isEmailConfirmed
      ];
}

// ignore: must_be_immutable
class UserInbox extends Equatable with Mappable {
  UserInbox({this.userId, this.fullName});
  int? userId;
  String? fullName;
  @override
  void mapping(Mapper map) {
    map("userId", userId, (v) => userId = v);
    map("fullName", fullName, (v) => fullName = v);
  }

  factory UserInbox.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return UserInbox();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<UserInbox>();
    return obj ?? UserInbox();
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_this
    return this.toJson();
  }

  @override
  List<Object?> get props => [userId, fullName];
}
