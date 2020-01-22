// import 'package:banking_app/bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

abstract class LoginFlowEvent {
  const LoginFlowEvent();
}

// For the login page
class LoginExistingUser extends LoginFlowEvent {
  final String email;
  final String password;

  LoginExistingUser({this.email, this.password});
}

// For signuppage2
class CreateAndLoginNewUser extends LoginFlowEvent {
  final String email;
  final String password;

  CreateAndLoginNewUser({this.email, this.password});
}

// For signuppage2
class CreateUserDocument extends LoginFlowEvent {

}

// For whenever the first "Next" button is clicked, and at signuppage2
class UpdateDetails extends  LoginFlowEvent {
  final Map<String, String> newDetails;

  UpdateDetails(this.newDetails);
  }