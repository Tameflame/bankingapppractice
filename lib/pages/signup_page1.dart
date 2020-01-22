import 'package:flutter/material.dart';
import 'package:banking_app/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banking_app/bloc/bloc.dart';

class SignupPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * (2 / 3),
          decoration: BoxDecoration(
            color: AppSwatch.backgroundGreen,
          ),
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
            SignupFormContainer(),
          ],
        ),
      ]),
    );
  }
}

class SignupFormContainer extends StatefulWidget {
  @override
  _SignupFormContainerState createState() => _SignupFormContainerState();
}

class _SignupFormContainerState extends State<SignupFormContainer> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  String _firstName = "";
  String _lastName = "";
  String _addressLine1 = "";
  String _postCode = "";
  String _country; // Maybe initialise it to a value?
  List<String> _countries = ["Brunei", "Indonesia", "Malaysia", "Singapore"];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressLine1Controller.dispose();
    _postCodeController.dispose();
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
          Column(
            children: <Widget>[
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
                height: MediaQuery.of(context).size.height*0.54,
                child: _signupPage1Form()),
              _nextAndSupportButtons()
            ],
          )
        ],
      ),
    );
  }

  Widget _signupPage1Form() {
    return Column(
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _firstNameController,
          decoration: InputDecoration(hintText: "First Name"),
          onChanged: (value) {
            _firstName = value;
          },
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _lastNameController,
          decoration: InputDecoration(hintText: "Last Name"),
          onChanged: (value) {
            _lastName = value;
          },
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _addressLine1Controller,
          decoration: InputDecoration(hintText: "Street Address"),
          onChanged: (value) {
            _addressLine1 = value;
          },
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: TextFormField(
          controller: _postCodeController,
          decoration: InputDecoration(hintText: "Post Code"),
          onChanged: (value) {
            _postCode = value;
          },
          autocorrect: false,
        ),
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: DropdownButton<String>(
          underline: Container(
            height: 1,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 0.0,
                ),
              ),
            ),
          ),
          isExpanded: true,
          value: _country,
          onChanged: (value) {
            setState(() {
              _country = value;
              print(_country);
            });
          },
          hint: Text("Select your country"),
          items: _countries.map((String country) {
            return DropdownMenuItem(
              child: Text("$country"),
              value: country,
            );
          }).toList(),
        ),
      )
    ]);
  }

  Widget _nextAndSupportButtons() {
    return Column(children: <Widget>[
        // Divider(height: MediaQuery.of(context).size.height*0.1,),
      Container(
        width: double.infinity,
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: FlatButton(
          onPressed: () {
            // Let's push this shit to the login bloc
            // print("Details are: $_firstName, $_lastName, \n $_addressLine1, $_postCode");
            // Navigator.of(context).pushNamed("/SignupPage2");
            BlocProvider.of<LoginFlowBloc>(context).add(UpdateDetails(
              <String, String>{
                "firstName" : _firstName,
                "lastName" : _lastName,
                "addressLine1" : _addressLine1,
                "postCode" : _postCode
              }
            ));
            Navigator.of(context).pushNamed("/SignupPage2");
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
      Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Text(
          "Need Support?",
          style: TextStyle(color: AppSwatch.foregroundGreen, fontSize: 18),
        ),
      ),
    ]);
  }
}
