import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/constants.dart';
import '../routes.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({Key key}) : super(key: key);

  // Create the initialization Future outside of `build`:

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: firstPage(context));
  }
}

Widget firstPage(BuildContext context) {
  return Scaffold(
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primaryWhiteColor,
      padding: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Image(
            image: AssetImage('assets/avokadio_logo.png'),
            width: 150,
            height: 150,
          ),
          Text(
            "avokadio",
            style: TextStyle(color: primaryGreenColor, fontSize: 55),
          ),
          SizedBox(
            height: 250,
          ),
          Container(
            width: 200,
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.signup);
                },
                child: Text("Get Started")),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 200,
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                },
                child: Text("Log In")),
          ),
          Text(
            "Already have an account ?",
            style: TextStyle(color: Color(0xFF1b8c3a), fontSize: 17),
          )
        ],
      ),
    ),
  );
}
