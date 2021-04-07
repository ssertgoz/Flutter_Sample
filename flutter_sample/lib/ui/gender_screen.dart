import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../services/firestore_database.dart';

enum Gender { Male, Female }

class GenderScreen extends StatefulWidget {
  GenderScreen({Key key}) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  Gender gender;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    FirestoreDatabase db =
        FirestoreDatabase(uid: authProvider.currentUser().uid);

    return StreamBuilder(
      stream: db.userStream(uid: authProvider.currentUser().uid),
      builder: (context, currentUser) => Scaffold(
        body: Container(
          child: Container(
            padding: EdgeInsets.only(bottom: 50, left: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primaryGreenColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: gender == Gender.Male
                              ? secondaryGreenColor
                              : primaryWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        setState(() {
                          gender = Gender.Male;
                        });
                      },
                      child: Text("Male",
                          style: TextStyle(
                              color: primaryGreenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: gender == Gender.Female
                              ? secondaryGreenColor
                              : primaryWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        setState(() {
                          gender = Gender.Female;
                        });
                      },
                      child: Text("Female",
                          style: TextStyle(
                              color: primaryGreenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: primaryWhiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    onPressed: () {
                      UserModel currentU = currentUser.data;
                      currentU.gender = gender.toString();
                      db.setUser(currentU);
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    },
                    child: Text(
                      "Continou",
                      style: TextStyle(color: primaryGreenColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
