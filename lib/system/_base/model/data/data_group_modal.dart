// ignore_for_file: empty_catches, unnecessary_this

import 'dart:convert';
import 'package:object_mapper/object_mapper.dart';
import '../../../connect/modals/data_link_modal.dart';
import 'data_group_user_modal.dart';
import 'data_organization_modal.dart';

class DataGroupModal with Mappable {
  String? key;
  String? name;
  int numberNotRead;
  String? type;
  DateTime? creationTime;
  DateTime? lastModificationTime;
  int? convertDateTime;
  String? value;
  String? value1;
  String title = "";
  DataLinkModal? dataLinkModal;
  String? view = "";
  String? role;
  String? parentId;
  int? index;
  bool? isGroupExchange;
  DataGroupUserModal? member;
  List<DataOrganizationModal>? listOrganization;
  List<DataGroupModal>? listChild;

  DataGroupModal({
    this.key,
    this.name,
    this.numberNotRead = 0,
    this.type,
    this.creationTime,
    this.lastModificationTime,
    this.value,
    this.value1,
    this.title = "",
    this.role,
    this.parentId,
    this.index,
    this.isGroupExchange,
    this.member,
    this.listChild,
    this.listOrganization,
  });

  @override
  void mapping(Mapper map) {
    map("key", key, (v) => key = v);
    map("name", name, (v) => name = v);
    map("numberNotRead", numberNotRead, (v) => numberNotRead = v ?? 0);
    map("type", type, (v) => type = v);
    map("creationTime", creationTime, (v) => creationTime = v,
        const DateTransform());
    map("lastModificationTime", lastModificationTime,
        (v) => lastModificationTime = v, const DateTransform());
    map("value", value, (v) => value = v);
    map("value1", value1, (v) => value1 = v);
    map("role", role, (v) => role = v);
    map("isGroupExchange", isGroupExchange, (v) => isGroupExchange = v);
    map("parentId", parentId, (v) => parentId = v);
    map("index", index, (v) => index = v);
    map<DataGroupUserModal>("member", member, (v) => member = v);
    map("title", title, (v) => title = v ?? "");
  }

  factory DataGroupModal.fromJson(Map<String, dynamic>? jsonInput, int userId) {
    if (jsonInput == null) {
      return DataGroupModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataGroupModal>();

    if (obj != null) {
      if (obj.value != null) {
        try {
          obj.listOrganization =
              (json.decode(obj.value!)["listOrganization"] as Iterable)
                  .map((e) => DataOrganizationModal.fromJson(e))
                  .toList();
        } catch (e) {}
      }

      if (obj.value1 != null) {
        try {
          var listUser = (json.decode(obj.value1!) as Iterable)
              .map((e) => DataGroupUserInfoModal.fromJson(e))
              .toList();

          obj.title = "";
          listUser.where((user) => user.userId != userId).forEach((user) {
            obj.title += "<${user.fullName!}>";
          });

          obj.title = obj.title
              .replaceAll("><", " - ")
              .replaceAll(">", "")
              .replaceAll("<", "");
        } catch (e) {}
      }
      if (obj.name != null) {
        obj.title = obj.title != "" ? obj.title : obj.name!;
      } else {
        obj.name = "";
      }
    }

    return obj ?? DataGroupModal();
  }

  Map<String, dynamic> toMap() {
    this.value = jsonEncode(this.listOrganization);

    return this.toJson();
  }
}
