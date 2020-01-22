// import 'package:banking_app/bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

abstract class LoginFlowState {
  const LoginFlowState();
}

class AttemptingToLoginExistingUser extends LoginFlowState{
}

class AttemptingToCreateNewUser extends LoginFlowState{
}

class SuccessfullyLoggedIn extends LoginFlowState {
}

class FailedToLogin extends LoginFlowState {
  final String reason;
  FailedToLogin(this.reason);
}

class NotLoggedIn extends LoginFlowState {
}