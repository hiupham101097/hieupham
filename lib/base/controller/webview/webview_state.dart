import 'package:equatable/equatable.dart';
import '../../../system/_base/model/content/bloc_status.dart';

// ignore: must_be_immutable
class WebviewState extends Equatable {
  WebviewState(
      {this.status = StatusWidget.initial,
      this.hasReachedMax = false,
      this.view});

  final StatusWidget? status;
  final bool hasReachedMax;
  String? view;

  WebviewState copyWith(
      {StatusWidget? status, bool? hasReachedMax, String? view}) {
    return WebviewState(
      status: status ?? this.status,
      view: view ?? this.view,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, hasReachedMax, view];
}
