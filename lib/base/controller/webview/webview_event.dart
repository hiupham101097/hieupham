import 'package:equatable/equatable.dart';

abstract class WebviewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WebviewFetched extends WebviewEvent {}

// ignore: must_be_immutable
class WebviewModelChange extends WebviewEvent {
  WebviewModelChange(this.view);

  String view;
  @override
  List<Object> get props => [view];
}

 