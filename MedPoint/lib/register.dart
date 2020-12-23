import 'package:doctor/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:doctor/designcolor/constant.dart';
import 'package:doctor/designcolor/rounded_button.dart';
import 'package:doctor/designcolor/text.dart';
import 'package:doctor/designcolor/reglog.dart';

import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController nameRegister = TextEditingController();
  TextEditingController emailRegister = TextEditingController();
  TextEditingController passwordRegister = TextEditingController();

  bool _isLoading = false;

  dataCreateUser(String name, String email, String password) async {
    String myUrl = "http://192.168.43.204:8000/api/register";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {"name": "$name", "email": "$email", "password": "$password"});
    print("Response status: ${response.statusCode}");
    print("Response status: ${response.body}");
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Successfully created account!."),
              actions: <Widget>[
                RaisedButton(
                  color: kPrimaryColor,
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  clearText() {
    nameRegister.clear();
    emailRegister.clear();
    passwordRegister.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
            ))
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/med.png",
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    child: Column(
                      children: [
                        TextField(
                          controller: nameRegister,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: "Name",
                            border: InputBorder.none,
                          ),
                        ),
                        // TextField(
                        //   cursorColor: kPrimaryColor,
                        //   decoration: InputDecoration(
                        //       icon: Icon(Icons.calendar_today),
                        //       hintText: "Date of birth",
                        //       border: InputBorder.none),
                        // ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailRegister,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                        TextField(
                          controller: passwordRegister,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            hintText: "Password",
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    text: "REGISTER",
                    press: () {
                      setState(() {
                        _isLoading = true;
                      });

                      dataCreateUser(nameRegister.text, emailRegister.text,
                          passwordRegister.text);
                      clearText();
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      print("na click padulong login");
                      setState(() {
                        _isLoading = true;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Click to login'),
                  ),
                ],
              ),
            ),
    );
  }
}
