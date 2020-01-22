import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:banking_app/api/auth/auth.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => Uninitialized();

  final AuthApi _authApi;

  AuthenticationBloc({@required AuthApi authApi})
      : assert(authApi != null),
        _authApi = authApi;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield Uninitialized();
    await Future.delayed(Duration(milliseconds: 300));

    try {
      if (await _authApi.isSignedIn()) {
        final _user = await _authApi.getUser();
        yield Authenticated(_user);
      } else {
        yield NotAuthenticated();
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    try {
      final _user = await _authApi.getUser();
      yield Authenticated(_user);
    } catch (e) {}
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield NotAuthenticated();
    _authApi.logOutExistingUser(); // This should be handled by the login bloc
  }
}
