import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../services/firestore_database.dart';

enum Motivation { LoseWeight, GainMuscle, Wellness }

class MotivationScreen extends StatefulWidget {
  MotivationScreen({Key key}) : super(key: key);

  @override
  _MotivationScreenState createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  Motivation motivation;

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
                  padding: EdgeInsets.only(bottom: 50),
                  width: 400,
                  child: Text(
                    """What is your motivatioun ?
                    """,
                    style: TextStyle(
                        color: primaryWhiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: motivation == Motivation.LoseWeight
                            ? secondaryGreenColor
                            : primaryWhiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    onPressed: () {
                      setState(() {
                        motivation = Motivation.LoseWeight;
                      });
                    },
                    child: Text("Lose weight",
                        style: TextStyle(
                            color: primaryGreenColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: motivation == Motivation.GainMuscle
                              ? secondaryGreenColor
                              : primaryWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        setState(() {
                          motivation = Motivation.GainMuscle;
                        });
                      },
                      child: Text("Gain muscle",
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
                          primary: motivation == Motivation.Wellness
                              ? secondaryGreenColor
                              : primaryWhiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      onPressed: () {
                        setState(() {
                          motivation = Motivation.Wellness;
                        });
                      },
                      child: Text("Wellness",
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
                      currentU.motivation = motivation.toString();
                      db.setUser(currentU);
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.physical);
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
