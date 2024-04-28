import 'package:object_mapper/object_mapper.dart';
import 'package:qlcv/system/_base/model/users/profile_model.dart';
import 'package:qlcv/system/_variables/value/key_value_model.dart';

import '../../model/setting/setting_model.dart';
import '../_base/model/content/criteria_value.dart';
import '../_base/model/content/file_data_model.dart';
import '../_base/model/content/login_model.dart';
import '../_base/model/content/token_model.dart';
import '../_base/model/data/data_device_token_modal.dart';
import '../_base/model/data/data_group_modal.dart';
import '../_base/model/data/data_group_user_modal.dart';
import '../_base/model/data/data_menu_modal_.dart';
import '../_base/model/data/data_organization_modal.dart';
import '../_base/model/data/data_tenant_modal.dart';
import '../_base/model/users/account_model.dart';
import '../_base/model/users/user_data_model.dart';
import '../connect/modals/data_link_modal.dart';

class StartMap {
  static void mapModal() {
    Mappable.factories = {
      FileDataModal: () => FileDataModal(),
      TokenModel: () => TokenModel(""),
      UserDataModal: () => UserDataModal(0, "", ""),
      UserInbox: () => UserInbox(),
      AccountModel: () => AccountModel(),
      LoginModel: () => LoginModel(),
      ProfileModel: () => ProfileModel(0),
      //CategoryModel: () => CategoryModel(),
      DataCriteriaModal: () => DataCriteriaModal(),
      DataDeviceTokenModal: () => DataDeviceTokenModal(),
      DataLinkModal: () => DataLinkModal(),
      DataOrganizationModal: () => DataOrganizationModal(),
      DataGroupModal: () => DataGroupModal(),
      DataGroupUserModal: () => DataGroupUserModal(),
      DataGroupUserInfoModal: () => DataGroupUserInfoModal(),
      DataMenuModal: () => DataMenuModal(),
      DataGetModal: () => DataGetModal(),
      DataTenantModal: () => DataTenantModal(),
      KeyValueModal: () => KeyValueModal(),
      SettingModelDto: () => SettingModelDto(),
    };
  }
}
