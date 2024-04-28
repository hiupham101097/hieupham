import 'package:object_mapper/object_mapper.dart';

class DataOrganizationModal with Mappable {
  String? id;
  String? code;
  String? name;

  DataOrganizationModal({
    this.id,
    this.code,
    this.name,
  });

  @override
  void mapping(Mapper map) {
    map("id", id, (v) => id = v);
    map("code", code, (v) => code = v);
    map("name", name, (v) => name = v);
  }

  factory DataOrganizationModal.fromJson(Map<String, dynamic>? jsonInput) {
    if (jsonInput == null) {
      return DataOrganizationModal();
    }

    var obj = Mapper.fromJson(jsonInput).toObject<DataOrganizationModal>();
    return obj ?? DataOrganizationModal();
  }
}
