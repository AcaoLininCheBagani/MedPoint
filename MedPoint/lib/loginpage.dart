import 'dart:convert';
import 'package:doctor/designcolor/rounded_button.dart';
import 'package:doctor/designcolor/text.dart';
import 'package:doctor/register.dart';
import 'package:doctor/wheretheyland.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'designcolor/constant.dart';
import 'designcolor/reglog.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  //this function para ma connect nako tong API
  signIn(String email, password) async {
    String url = "http://192.168.43.204:8000/api/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email": email, "password": password};
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

        sharedPreferences.setString("token", jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LandHere()),
            (route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print("Response status: ${res.body}");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid"),
              content: Text("Invalid email or password."),
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
                          controller: _emailController,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                        TextField(
                          controller: _passwordController,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
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
                    text: "LOGIN",
                    press: () {
                      setState(() {
                        _isLoading = true;
                      });
                      signIn(_emailController.text, _passwordController.text);
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      print("na click padulong register");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Not yet registered?'),
                  ),
                ],
              ),
            ),
    );
  }
}
