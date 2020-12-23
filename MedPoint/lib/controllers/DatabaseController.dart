library databasecontroller.dart;

import 'dart:convert';

import 'package:doctor/designcolor/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Record {
  int id;
  String name;
  String email;

  Record({this.name, this.email, this.id});

  factory Record.responseJson(final json) {
    return Record(
      id: json["id"],
      email: json["email"],
      name: json["name"],
    );
  }
}

class Get {
  SharedPreferences sharedPreferences;

  //getting current user login, information
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
      sharedPreferences.setInt("id", jsonRecord['id']);

      return Record.responseJson(jsonRecord);
    } else {
      throw Exception();
    }
  }

//logout
  logOutUser() async {
    String url = "http://192.168.43.204:8000/api/logout";

    var key = sharedPreferences.getString("token");

    http.Response response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    });
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      sharedPreferences.clear();
    }
  }

  //delete
  deleteaccount() async {
    int id = sharedPreferences.getInt("id");
    print("id: $id");
    String url = "http://192.168.43.204:8000/api/delete/$id";
    final key = sharedPreferences.getString("token");
    http.Response response = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    });
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  }

//update
  upDate(String name, String email) async {
    int id = sharedPreferences.getInt("id");
    print("id: $id");
    String url = "http://192.168.43.204:8000/api/update/$id";
    final key = sharedPreferences.getString("token");
    http.Response response = await http.put(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }, body: {
      "name": "$name",
      "email": "$email",
    });
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
    final js = jsonDecode(response.body);
    sharedPreferences.setString("status", js['status']);
    sharedPreferences.setString("message", js['message']);
  }

  //show dialog
  void showSampleDialog(BuildContext context) async {
    final k = sharedPreferences.getString("status");
    final v = sharedPreferences.getString("message");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$k"),
          content: Text("$v"),
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
      },
    );
  }
}
