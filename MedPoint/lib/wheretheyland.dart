import 'package:doctor/appointment.dart';
import 'package:doctor/controllers/DatabaseController.dart';
import 'package:doctor/designcolor/constant.dart';
import 'package:doctor/designcolor/text.dart';
import 'package:doctor/loginpage.dart';
import 'package:doctor/profile.dart';
import 'package:doctor/wheretheylandcategorycard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
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
  Get getter = new Get();
  @override
  void initState() {
    super.initState();
    checkLogin();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MedPoint", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Search for the best \nDoctor",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFieldContainer(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search the best doctor",
                            border: InputBorder.none,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                categoryCard(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Doctors",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: FutureBuilder<Record>(
            future: getter.getAuthUser(),
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MakeAppointment()));
                          }),
                      ListTile(
                          title: new Text("View appointment"),
                          trailing: new Icon(Icons.settings),
                          onTap: () {}),
                      SizedBox(height: 80),
                      ListTile(
                          title: new Text("DELETE ACCOUNT"),
                          trailing: new Icon(Icons.delete),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("WARNING"),
                                    content: Text(
                                        "Do you want to delete account?!."),
                                    actions: <Widget>[
                                      RaisedButton(
                                        color: kPrimaryColor,
                                        child: Text("Yes"),
                                        onPressed: () {
                                          getter.deleteaccount();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          LoginScreen()),
                                                  (route) => false);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }),
                      SizedBox(height: 80),
                      FlatButton.icon(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Logout"),
                                  content: Text("Are you sure?!."),
                                  actions: <Widget>[
                                    RaisedButton(
                                      color: kPrimaryColor,
                                      child: Text("Ok"),
                                      onPressed: () {
                                        getter.logOutUser();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        LoginScreen()),
                                                (route) => false);
                                      },
                                    ),
                                  ],
                                );
                              });
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

categoryCard() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        WhereTheyLandCategoryCard(),
        WhereTheyLandCategoryCard(),
        WhereTheyLandCategoryCard(),
        WhereTheyLandCategoryCard(),
        WhereTheyLandCategoryCard(),
      ],
    ),
  );
}
