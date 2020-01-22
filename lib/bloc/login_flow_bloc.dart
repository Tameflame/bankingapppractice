import 'dart:async';
import 'package:banking_app/api/auth/auth.dart';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class LoginFlowBloc extends Bloc<LoginFlowEvent, LoginFlowState> {
  final AuthApi _authApi = new AuthApi();
  Map<String, String> _userDetails = {};

  @override
  LoginFlowState get initialState => NotLoggedIn();

  @override
  Stream<LoginFlowState> mapEventToState(
    LoginFlowEvent event,
  ) async* {
    if (event is LoginExistingUser) {
      yield AttemptingToLoginExistingUser();
      // IMPORTANT: Figure this thing out.
      // Even if i wrap the method in try/catch, it always just continues on
      // I don't know why the exceptions (the catch statements) aren't being handled
      try {
        await _authApi.loginExistingUser(event.email, event.password);
        if (await _authApi.isSignedIn()) {
        yield SuccessfullyLoggedIn();}
        else {
        yield FailedToLogin("Need to fix the dang try/catch blocs not working on firebase_auth exceptions!");
        yield NotLoggedIn();}
      } catch (e) {
        await Future.delayed(Duration(milliseconds: 500));
        yield FailedToLogin(e.toString());
      }
    } else if (event is UpdateDetails) {
      _userDetails.addAll(event.newDetails);
      print("Btw, details are now $_userDetails");
      yield NotLoggedIn();
    } else if (event is CreateAndLoginNewUser) {
      yield AttemptingToCreateNewUser();
      try {
        await _authApi.createNewUser(event.email, event.password);

      } catch (e) {
        await Future.delayed(Duration(milliseconds: 500));
        yield FailedToLogin(e.toString());
      }
      if (await _authApi.isSignedIn()) {
        yield SuccessfullyLoggedIn();
      } else {
        await Future.delayed(Duration(milliseconds: 500));
        yield FailedToLogin("Idk pal");
        yield NotLoggedIn();
      }
    } else if (event is CreateUserDocument) {
      // Implement User Document creation
      // Not sure if yielding state is right here, but whatever xd
      yield state;
    }
  }
}
