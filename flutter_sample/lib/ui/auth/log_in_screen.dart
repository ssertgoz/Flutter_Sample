import 'package:flutter/material.dart';
import 'package:flutter_sample/app_localization.dart';
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

  Widget buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterLogo(
                    size: 128,
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  style: Theme.of(context).textTheme.bodyText2,
                  validator: (value) => value.isEmpty ? "Empty E-mail" : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      labelText: "Enter E-mail",
                      border: OutlineInputBorder()),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 12,
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodyText2,
                    validator: (value) =>
                        value.length < 6 ? "At least 6 character" : null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        labelText: "Enter password",
                        border: OutlineInputBorder()),
                  ),
                ),
                authProvider.status == Status.Registering
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        child: Text(""
                            /* AppLocalizations.of(context)
                              .translate("loginBtnSignUp"),
                          style: Theme.of(context).textTheme.button, */
                            ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context)
                                .unfocus(); //to hide the keyboard - if any

                            UserModel userModel =
                                await authProvider.registerWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text);

                            /* if (userModel == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar((SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .translate("loginTxtErrorSignIn")),
                              )));
                            } */
                          }
                        }),
                authProvider.status == Status.Registering
                    ? Center(
                        child: null,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Center(
                            child: Text(""
                                /* AppLocalizations.of(context)
                              .translate("loginTxtHaveAccount"),
                          style: Theme.of(context).textTheme.button, */
                                )),
                      ),
                authProvider.status == Status.Registering
                    ? Center(
                        child: null,
                      )
                    : TextButton(
                        child: Text(
                            "" /* AppLocalizations.of(context)
                            .translate("loginBtnLinkSignIn") */
                            ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.login);
                        },
                      ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBackground() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFF1b8c3a));
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
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(Routes.elogin);
                  },
                  child: Text("E-mail",
                      style: TextStyle(
                          color: Color(0xFF1b8c3a),
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
                      primary: Colors.white,
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
                          color: Color(0xFF1b8c3a),
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
            )
          ],
        ));
  }
}
