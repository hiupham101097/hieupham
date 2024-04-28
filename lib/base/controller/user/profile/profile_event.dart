import 'package:equatable/equatable.dart';
import 'package:qlcv/system/_base/model/users/account_model.dart';

import '../../../../system/_base/model/users/profile_model.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileFetched extends ProfileEvent {}

// ignore: must_be_immutable
class ProfileModelChange extends ProfileEvent {
  ProfileModelChange(this.view);

  late String view;
  @override
  List<Object> get props => [view];
}

// ignore: must_be_immutable
class ButtonProfileSave extends ProfileEvent {
  ButtonProfileSave(this.profileModel, this.account, this.view);

  late ProfileModel profileModel;
  late AccountModel account;
  late String view;

  @override
  List<Object> get props => [profileModel, account, view];
}
