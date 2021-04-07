import 'package:flutter/material.dart';
import 'package:flutter_sample/app_localization.dart';
import 'package:flutter_sample/constants/constants.dart';
import 'package:flutter_sample/models/user_model.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/routes.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: _buildForm(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primaryGreenColor);
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.elogin);
                  },
                  child: Text("E-mail",
                      style: TextStyle(
                          color: primaryGreenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              width: 150,
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onPressed: () async {
                    UserModel userModel = await authProvider.signInWithGoogle();

                    if (userModel == null) {
                      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                        content: Text(
                          "Error",
                        ),
                      )));
                    } else {
                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    }
                  },
                  child: Text("Google",
                      style: TextStyle(
                          color: primaryGreenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
            )
          ],
        ));
  }
}
