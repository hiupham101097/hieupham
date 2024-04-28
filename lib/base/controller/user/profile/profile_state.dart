import 'package:equatable/equatable.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';

import '../../../../system/_base/model/users/profile_model.dart';

// ignore: must_be_immutable
class ProfileState extends Equatable {
  ProfileState(
      {this.status = StatusWidget.initial,
      this.profileModel,
      this.hasReachedMax = false,
      this.view = ''});
  final StatusWidget? status;
  final ProfileModel? profileModel;
  final bool hasReachedMax;
  String view;

  ProfileState copyWith(
      {StatusWidget? status,
      ProfileModel? profileModel,
      bool? hasReachedMax,
      String? view}) {
    return ProfileState(
        status: status ?? this.status,
        profileModel: profileModel ?? this.profileModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        view: view ?? this.view);
  }

  @override
  String toString() {
    return '''ClassState { status: $status, hasReachedMax: $hasReachedMax, profileModel:$profileModel}, view:$view}''';
  }

  @override
  List<Object?> get props => [status, profileModel, hasReachedMax, view];
}
