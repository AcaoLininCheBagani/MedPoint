import 'dart:convert';

import 'package:doctor/wheretheyland.dart';
import 'package:flutter/material.dart';
import 'package:doctor/designcolor/constant.dart';
import 'package:doctor/designcolor/rounded_button.dart';
import 'package:doctor/designcolor/text.dart';
import 'package:doctor/designcolor/reglog.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  create(String name, String email, password) async {
    String url = "http://192.168.43.204:8000/api/register";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"name": name, "email": email, "password": password};
    var jsonResponse = null;
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");
      print("Response status: ${res.body}");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        //check for this later
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LandHere()),
            (route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print("Response status: ${res.body}");
    }
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
                        TextField(
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today),
                              hintText: "Date of birth",
                              border: InputBorder.none),
                        ),
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
                      create(nameRegister.text, emailRegister.text,
                          passwordRegister.text);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
