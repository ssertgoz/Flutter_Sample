import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class MotivationScreen extends StatefulWidget {
  MotivationScreen({Key key}) : super(key: key);

  @override
  _MotivationScreenState createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          padding: EdgeInsets.only(bottom: 50, left: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1b8c3a),
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
                      color: Colors.white,
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
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                  child: Text("Lose weight",
                      style: TextStyle(
                          color: Color(0xFF1b8c3a),
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
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                    },
                    child: Text("Gain muscle",
                        style: TextStyle(
                            color: Color(0xFF1b8c3a),
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 200,
                height: 30,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                    },
                    child: Text("Wellness",
                        style: TextStyle(
                            color: Color(0xFF1b8c3a),
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
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.physical);
                  },
                  child: Text(
                    "Continou",
                    style: TextStyle(color: Color(0xFF1b8c3a)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
