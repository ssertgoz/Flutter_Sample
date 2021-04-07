import 'package:flutter/material.dart';

import '../routes.dart';

class GenderScreen extends StatefulWidget {
  GenderScreen({Key key}) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
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
                    child: Text("Male",
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
                    child: Text("Female",
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
                    Navigator.of(context).pushReplacementNamed(Routes.home);
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
