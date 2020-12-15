import 'dart:convert';

import 'package:doctor/controllers/DatabaseController.dart';
import 'package:doctor/loginpage.dart';
import 'package:doctor/profile.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LandHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Diri mag landing",
      debugShowCheckedModeBanner: false,
      home: LandPage(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class LandPage extends StatefulWidget {
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLogin();
    getAuthUser();
  }

  checkLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //print(sharedPreferences.getString("token"));
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (route) => false);
    }
  }

  Future<Record> getAuthUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var key = sharedPreferences.getString("token");

    String url = "http://192.168.43.204:8000/api/user";

    http.Response response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    });

    print(json.decode(response.body));
    print("Response status user: ${response.statusCode}");
    print("Response status user: ${response.body}");
    if (response.statusCode == 200) {
      final jsonRecord = jsonDecode(response.body);
      return Record.responseJson(jsonRecord);
    } else {
      throw Exception();
    }
    // var gg = jsonDecode(response.body);
    // sharedPreferences.setString("name", gg['name']);
    // sharedPreferences.setString("email", gg['email']);

    // // print("$gg3");
    // // print("$gg4");
    // //sharedPreferences.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MedPoint", style: TextStyle(color: Colors.white)),
      ),
      body: Center(),
      drawer: Drawer(
        child: FutureBuilder<Record>(
            future: getAuthUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Drawer(
                  child: ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                          accountName: Text("${snapshot.data.name}"),
                          accountEmail: Text("${snapshot.data.email}")),
                      ListTile(
                          trailing: new Icon(Icons.verified_user),
                          title: new Text("Update user information"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateUserInfo()));
                          }),
                      ListTile(
                          title: new Text("Change password"),
                          trailing: new Icon(Icons.account_circle),
                          onTap: () {}),
                      ListTile(
                          title: new Text("Settings"),
                          trailing: new Icon(Icons.settings),
                          onTap: () {}),
                      ListTile(
                          title: new Text("Make appointment"),
                          trailing: new Icon(Icons.settings),
                          onTap: () {}),
                      ListTile(
                          title: new Text("View appointment"),
                          trailing: new Icon(Icons.settings),
                          onTap: () {}),
                      FlatButton.icon(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onPressed: () {
                          sharedPreferences.clear();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginScreen()),
                              (route) => false);
                        },
                        icon: Icon(Icons.lock_open),
                        label: Text("Logout"),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              );
            }),
      ),
    );
  }
}
