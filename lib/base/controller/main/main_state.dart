part of 'main_bloc.dart';

class MainState extends Equatable {
  const MainState._({
    required this.status,
  });
  const MainState.unknown() : this._(status: BlocStatus.unknown);
  const MainState.authenticated() : this._(status: BlocStatus.authenticated);
  const MainState.unauthenticated()
      : this._(status: BlocStatus.unauthenticated);

  final BlocStatus status;

  @override
  List<Object> get props => [status];
}

class MainRepository {
  final _controller = StreamController<BlocStatus>();

  Stream<BlocStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield BlocStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(BlocStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(BlocStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

