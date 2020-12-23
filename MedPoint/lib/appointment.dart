import 'package:doctor/designcolor/rounded_button.dart';
import 'package:flutter/material.dart';

class MakeAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: "Reason for appointment",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Description",
                ),
              ),
            ),
            SizedBox(
              height: 220,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  text: "Appoint Example",
                  press: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
