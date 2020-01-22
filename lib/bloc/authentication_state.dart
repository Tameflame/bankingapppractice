import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState{

  final FirebaseUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => "Authenticated: {displayName: ${user.displayName ?? user.email}";
}
class NotAuthenticated extends AuthenticationState{

  @override
  List<Object> get props => [];

}