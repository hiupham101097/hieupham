import 'package:equatable/equatable.dart';
import 'package:qlcv/system/_base/model/content/bloc_status.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  const HomeState(
      {this.status = StatusWidget.initial,
      this.hasReachedMax = false,
      this.view = ""});

  final StatusWidget? status;
  final bool hasReachedMax;
  final String? view;

  HomeState copyWith(
      {StatusWidget? status, bool? hasReachedMax, String view = ""}) {
    return HomeState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
