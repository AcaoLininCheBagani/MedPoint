import 'dart:convert';

import 'package:doctor/controllers/DatabaseController.dart';
import 'package:doctor/designcolor/rounded_button.dart';
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
  Get getter = new Get();
  TextEditingController emailControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.deepOrangeAccent,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        child: FutureBuilder<Record>(
          future: getter.getAuthUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.blueAccent.withOpacity(0.1),
                                      offset: Offset(0, 10)),
                                ],
                                shape: BoxShape.circle,
                                // image: DecorationImage(
                                //   image:NetworkImage(url)
                                //   )
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      buildTextField(
                          "Full Name", "${snapshot.data.name}", nameControl),
                      buildTextField(
                          "Email", "${snapshot.data.email}", emailControl),
                      SizedBox(
                        height: 220,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RoundedButton(
                            text: "Update information",
                            press: () {
                              getter.upDate(
                                  nameControl.text, emailControl.text);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            );
          },
        ),
      ),
      // child: FutureBuilder<Record>(
      //     future: getto.getAuthUser(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return Text(
      //             "Name : ${snapshot.data.name} \n Email : ${snapshot.data.email}");
      //       }
      //       if (snapshot.hasError) {
      //         return Text(snapshot.error.toString());
      //       }
      //       return CircularProgressIndicator(
      //         backgroundColor: Colors.blueGrey,
      //       );
      //     }),
    );
  }

  Widget buildTextField(String labelText, String placeholder, controlMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controlMode,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
