import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlcv/base/controller/user/profile/profile_event.dart';
import 'package:qlcv/base/controller/user/profile/profile_state.dart';
import 'package:qlcv/system/_base/controller/user_component.dart';

import '../../../../main.dart';
import '../../../../system/_base/model/content/bloc_status.dart';
import '../../../../system/_base/model/content/global_model.dart';
import '../../../../system/_base/model/users/profile_model.dart';
import '../../../../system/_variables/http/app_http_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(BuildContext? context, GlobalModel? globalModel)
      : super(ProfileState()) {
    _globalModel = globalModel;
    on<ProfileFetched>(
      _onClassFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<ProfileModelChange>(_changeViewModalValues);
    on<ButtonProfileSave>(_buttonViewModalValues);
  }

  GlobalModel? _globalModel;

  Future<void> _onClassFetched(
    ProfileFetched event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == StatusWidget.initial) {
        var item = ProfileModel(_globalModel!.userDataModal.id!);
        item.emailAddress = _globalModel!.userDataModal.emailAddress;
        item.fullName = _globalModel!.userDataModal.fullName;
        item.phoneNumber = _globalModel!.userDataModal.phoneNumber ?? " ";
        item.address = _globalModel!.userDataModal.address;
        return emit(state.copyWith(
          status: StatusWidget.success,
          profileModel: item,
          hasReachedMax: false,
        ));
      }
      var item = ProfileModel(_globalModel!.userDataModal.id!);
      item.emailAddress = _globalModel!.userDataModal.emailAddress;
      item.fullName = _globalModel!.userDataModal.fullName;
      item.phoneNumber = _globalModel!.userDataModal.phoneNumber;
      item.address = _globalModel!.userDataModal.address;
      final user = item;
      // ignore: unnecessary_null_comparison
      user != null
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: StatusWidget.success,
                profileModel: user,
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: StatusWidget.failure));
    }
  }

  Future<void> _changeViewModalValues(
    ProfileModelChange event,
    Emitter<ProfileState> emit,
  ) async {
    var value = event.view;
    emit(state.copyWith(view: value));
  }

  // ignore: unused_element
  Future<void> _buttonViewModalValues(
    ButtonProfileSave event,
    Emitter<ProfileState> emit,
  ) async {
    var profile = event.profileModel;

    var saveResult = await UserComponent().saveCurrenProfile(
      profile.toMap(),
    );

        await UserComponent().changeAccount(
      event.account.toMap(),
    );

    if (event.view == "V") {
      event.view = "";
    } else {
      event.view = "V";
    }

    if (saveResult.status == AppHttpModelStatus.Success) {
      globalModel.userDataModal
        ..fullName = profile.fullName
        ..emailAddress = profile.emailAddress
        ..phoneNumber = profile.phoneNumber
        ..address = profile.address;
    }

    emit(state.copyWith(view: event.view, profileModel: profile));
  }
}
