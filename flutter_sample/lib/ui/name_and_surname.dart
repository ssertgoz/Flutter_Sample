import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/models/user_model.dart';
import 'package:provider/provider.dart';
import '../services/firestore_database.dart';
import '../routes.dart';

class NameSurnameScreen extends StatefulWidget {
  const NameSurnameScreen({Key key}) : super(key: key);

  @override
  _NameSurnameScreenState createState() => _NameSurnameScreenState();
}

class _NameSurnameScreenState extends State<NameSurnameScreen> {
  TextEditingController _nameController;
  TextEditingController _surnameController;
  TextEditingController _birthdayController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel _user;

  void didChangeDependencies() {
    super.didChangeDependencies();
    final UserModel _userModel = ModalRoute.of(context).settings.arguments;
    if (_userModel != null) {
      _user = _userModel;
    }

    _nameController =
        TextEditingController(text: _user != null ? _user.name : "");
    _surnameController =
        TextEditingController(text: _user != null ? _user.surName : "");

    _birthdayController =
        TextEditingController(text: _user != null ? _user.birthDay : "");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirestoreDatabase>(
        create: (context) => FirestoreDatabase(uid: _user.uid),
        child: MaterialApp(
          home: Form(
            key: _formKey,
            child: Scaffold(
              body: Container(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, left: 20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xFF1b8c3a),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 50),
                        width: 400,
                        child: Text(
                          """Welcome to avokadio Community, we are here to give you science backed wellness and nutrition advice  based on your daily routine
                      """,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 30, right: 20),
                              child: Text(
                                "Name ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 250,
                              child: TextFormField(
                                controller: _nameController,
                                style: Theme.of(context).textTheme.bodyText2,
                                validator: (value) =>
                                    value.isEmpty ? "Empty Name" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 30, right: 20),
                              child: Text(
                                "Surname ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 250,
                              child: TextFormField(
                                controller: _surnameController,
                                style: Theme.of(context).textTheme.bodyText2,
                                validator: (value) =>
                                    value.isEmpty ? "Empty" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 30, right: 20),
                              child: Text(
                                "Birtday",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 250,
                              child: TextFormField(
                                controller: _birthdayController,
                                style: Theme.of(context).textTheme.bodyText2,
                                validator: (value) =>
                                    value.isEmpty ? "Empty" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0))),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: 200,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //FocusScope.of(context).unfocus();

                              final firestoreDatabase =
                                  Provider.of<FirestoreDatabase>(context,
                                      listen: false);

                              firestoreDatabase.setUser(UserModel(
                                uid: _user != null
                                    ? _user.uid
                                    : documentIdFromCurrentDate(),
                                name: _nameController.text,
                                surName: _surnameController.text.length > 0
                                    ? _surnameController.text
                                    : "",
                              ));
                            }
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.motivation);
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
            ),
          ),
        ));
  }
}
