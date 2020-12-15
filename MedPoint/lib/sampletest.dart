//  drawer: Drawer(
//         child: ListView(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: Text("dadawdwadwad"),
//               //accountEmail: Text(sharedPreferences.getString("email")),
//               // decoration: BoxDecoration(
//               //     image: DecorationImage(
//               //   fit: BoxFit.fill,
//               //   image: AssetImage("assets/med.png"),
//               // )),
//             ),
//             ListTile(
//                 trailing: new Icon(Icons.verified_user),
//                 title: new Text("Update user information"),
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (BuildContext context) => UpdateUserInfo()));
//                 }),
//             ListTile(
//                 title: new Text("Change password"),
//                 trailing: new Icon(Icons.account_circle),
//                 onTap: () {}),
//             ListTile(
//                 title: new Text("Settings"),
//                 trailing: new Icon(Icons.settings),
//                 onTap: () {}),
//             ListTile(
//                 title: new Text("Make appointment"),
//                 trailing: new Icon(Icons.settings),
//                 onTap: () {}),
//             ListTile(
//                 title: new Text("View appointment"),
//                 trailing: new Icon(Icons.settings),
//                 onTap: () {}),
//             FlatButton.icon(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               onPressed: () {
//                 sharedPreferences.clear();

//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => LoginScreen()),
//                     (route) => false);
//               },
//               icon: Icon(Icons.lock_open),
//               label: Text("Logout"),
//             ),
//           ],
//         ),
//       ),
