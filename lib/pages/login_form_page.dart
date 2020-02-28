// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:banking_app/pages/pages_barrel.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/style.dart';
// import 'package:banking_app/api/auth/auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banking_app/bloc/bloc.dart';

class LoginFormPage extends StatefulWidget {
  @override
  _LoginFormPageState createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginFlowBloc, LoginFlowState>(
          listener: (context, state) {
            if (state is SuccessfullyLoggedIn) {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());

              /// Decide to whether to pass user as an argument
              /// or to instantiate it with bloclistener.
              /// probably less boilerplate the argument way
              /// actually maybe stick to the instance way
              /// since in real life i will be constantly updating data
              /// wonder how to implement that tho.
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //       builder: (context) => HomePage(),
              //     ),
              //     (_) => false);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/HomePage", (_) => false);
            } else if (state is AttemptingToLoginExistingUser) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Attempting to Sign In"),
              ));
            } else if (state is FailedToLogin) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Sign in failed - Please try again"),
              ));
            }
          },
          child: Stack(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * (2 / 3),
              decoration: BoxDecoration(color: AppSwatch.backgroundGreen),
            ),
            ListView(physics: ClampingScrollPhysics(), children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    // This is for my iphonee debugging, will probably need different values per iphone
                    // height: MediaQuery.of(context).size.height * 0.4,
                    // this is the original
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Center(
                      child: Container(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "A",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: ".",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: AppSwatch.foregroundGreen)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LoginFormContainer(),
              ),
            ])
          ])),
    );
  }
}

class LoginFormContainer extends StatefulWidget {
  @override
  _LoginFormContainerState createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _password = "";
  String _email = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Divider(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  _password = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: signinButton(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Need Support?",
                style: TextStyle(
                  color: AppSwatch.foregroundGreen,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ));
  }

  Widget signinButton() {
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        onPressed: () {
          print("Login Button Pressed!");
          print("Email: $_email, Password: $_password");
          // _auth.loginExistingUser(_email, _password).then((_) {
          //   _auth.isSignedIn().then((onValue) {
          //     if (onValue) {
          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil('/HomePage', (_) => false);
          //     } else {
          //       Scaffold.of(context).showSnackBar(SnackBar(
          //         content: Text("Sign in failed - Please try again"),
          //       ));
          //     }
          //   }
          //   );
          // }
          // );
          BlocProvider.of<LoginFlowBloc>(context)
              .add(LoginExistingUser(email: _email, password: _password));
        },
        child: Text(
          "Sign In",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppSwatch.foregroundGreen,
      ),
    );
  }
}
