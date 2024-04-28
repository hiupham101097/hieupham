part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends MainEvent {}

class MainStatusChanged extends MainEvent {
  const MainStatusChanged(this.status);

  final BlocStatus status;

  @override
  List<Object> get props => [status];
}

class AppUserChanged extends MainEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final UserDataModal user;

  @override
  List<Object> get props => [user];
}
