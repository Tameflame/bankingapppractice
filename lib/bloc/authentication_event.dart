

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}


class AppStarted extends AuthenticationEvent {
}

class LoggedIn extends AuthenticationEvent {
}

class LoggedOut extends AuthenticationEvent {
}