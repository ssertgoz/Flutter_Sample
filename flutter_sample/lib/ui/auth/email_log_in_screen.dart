import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/constants.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/routes.dart';
import 'package:provider/provider.dart';

class EmailLogInScreen extends StatefulWidget {
  @override
  _EmailLogInScreenState createState() => _EmailLogInScreenState();
}

class _EmailLogInScreenState extends State<EmailLogInScreen> {
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 100,
              width: 350,
              child: TextFormField(
                controller: _emailController,
                style: Theme.of(context).textTheme.bodyText2,
                validator: (value) => value.isEmpty ? "Empty E-mail" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  filled: true,
                  fillColor: primaryWhiteColor,
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  labelText: "Enter E-mail",
                ),
              ),
            ),
            Container(
              height: 100,
              width: 350,
              child: TextFormField(
                obscureText: true,
                maxLength: 12,
                controller: _passwordController,
                style: Theme.of(context).textTheme.bodyText2,
                validator: (value) =>
                    value.length < 6 ? "At least 6 character" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  filled: true,
                  fillColor: primaryWhiteColor,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  labelText: "Enter password",
                ),
              ),
            ),
            authProvider.status == Status.Registering
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: 200,
                    height: 30,
                    margin: EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryWhiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)))),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any

                            bool result =
                                await authProvider.signInWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);

                            if (!result) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar((SnackBar(
                                content: Text(
                                  "Error",
                                ),
                              )));
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.home);
                            }
                          }
                        },
                        child: Text("Sign In",
                            style: TextStyle(
                                color: primaryGreenColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
          ],
        ),
      ),
    );
  }
}
