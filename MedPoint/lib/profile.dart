import 'dart:convert';

import 'package:doctor/controllers/DatabaseController.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpdateUserInfo(),
    );
  }
}

class UpdateUserInfo extends StatefulWidget {
  UpdateUserInfo({
    Key key,
  }) : super(key: key);

  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {
  Future<Record> getAuthUser() async {
    String url2 = "http://192.168.43.204:8000/api/user";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var key = sharedPreferences.getString("token");
    http.Response response = await http.get(url2, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    });
    if (response.statusCode == 200) {
      final jsonRecord = jsonDecode(response.body);
      return Record.responseJson(jsonRecord);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: FutureBuilder<Record>(
            future: getAuthUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    "Name : ${snapshot.data.name} \n Email : ${snapshot.data.email}");
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
