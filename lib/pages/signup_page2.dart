// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/style.dart';
// import 'package:banking_app/api/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banking_app/bloc/bloc.dart';

class SignupPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener(
        bloc: BlocProvider.of<LoginFlowBloc>(context),
        listener: (context, state) {
          if (state is SuccessfullyLoggedIn) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            Navigator.of(context).popAndPushNamed('/HomePage');
          } else if (state is FailedToLogin) {
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("You messed up!"),
            ));
          } else if (state is AttemptingToCreateNewUser) {
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Attempting to Create Account"),
            ));
          }
        },
        child: Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * (1 / 3),
            decoration: BoxDecoration(color: AppSwatch.backgroundGreen),
          ),
          ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    padding: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "A",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            TextSpan(
                                text: ".",
                                style: TextStyle(
                                    fontSize: 50,
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
              Divider(
                height: 10,
              ),
              SignupFormPage2Container(),
            ],
          ),
        ]),
      ),
    );
  }
}

class SignupFormPage2Container extends StatefulWidget {
  @override
  _SignupFormPage2ContainerState createState() =>
      _SignupFormPage2ContainerState();
}

class _SignupFormPage2ContainerState extends State<SignupFormPage2Container> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passswordController = TextEditingController();
  TextEditingController _confirmPassswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String _email = "";
  String _password = "";
  String _confirmPasssword = "";
  String _phoneNumber = "";
  // final AuthApi _authAPI = AuthApi(firebaseAuth: FirebaseAuth.instance);

  // Map<String, String> _userInfo = {};

  @override
  void dispose() {
    _emailController.dispose();
    _passswordController.dispose();
    _confirmPassswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.54,
            child: _signupPage1form()),
        _nextAndSupportButtons()
      ]),
    );
  }

  Widget _signupPage1form() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(hintText: "Email Address"),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            _email = value;
          },
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _passswordController,
          decoration: InputDecoration(hintText: "Password"),
          onChanged: (value) {
            _password = value;
          },
          autocorrect: false,
          obscureText: true,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          obscureText: true,
          controller: _confirmPassswordController,
          decoration: InputDecoration(hintText: "Confirm Password"),
          onChanged: (value) {
            _confirmPasssword = value;
          },
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _phoneNumberController,
          decoration: InputDecoration(hintText: "Phone Number"),
          onChanged: (value) {
            _phoneNumber = value;
          },
          autocorrect: false,
          keyboardType: TextInputType.phone,
        ),
      )
    ]);
  }

  Widget _nextAndSupportButtons() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 55,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: FlatButton(
            onPressed: () {
              print("Let's try to log in");
              // BlocProvider.of<LoginFlowBloc>(context).add(UpdateDetails())
              BlocProvider.of<LoginFlowBloc>(context).add(
                  CreateAndLoginNewUser(email: _email, password: _password));
            },
            child: Text(
              "Next",
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
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Text(
          "Need Support?",
          style: TextStyle(color: AppSwatch.foregroundGreen, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 20),
        ),
      ],
    );
  }
}
