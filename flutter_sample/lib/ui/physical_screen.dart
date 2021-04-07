import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../routes.dart';
import '../services/firestore_database.dart';

class PhysicalScreen extends StatefulWidget {
  PhysicalScreen({Key key}) : super(key: key);

  @override
  _PhysicalScreenState createState() => _PhysicalScreenState();
}

class _PhysicalScreenState extends State<PhysicalScreen> {
  TextEditingController _weightController;
  TextEditingController _heightController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: "");
    _heightController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    FirestoreDatabase db =
        FirestoreDatabase(uid: authProvider.currentUser().uid);
    return StreamBuilder(
      stream: db.userStream(uid: authProvider.currentUser().uid),
      builder: (context, currentUser) => Form(
        key: _formKey,
        child: Scaffold(
          body: Container(
            child: Container(
              padding: EdgeInsets.only(bottom: 50, left: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xFF1b8c3a),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 400,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 30, right: 20),
                          child: Text(
                            "Weight ",
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
                            controller: _weightController,
                            style: Theme.of(context).textTheme.bodyText2,
                            validator: (value) =>
                                value.isEmpty ? "Empty" : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0))),
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
                            "Height",
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
                            controller: _heightController,
                            style: Theme.of(context).textTheme.bodyText2,
                            validator: (value) =>
                                value.isEmpty ? "Empty" : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0))),
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
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          //FocusScope.of(context).unfocus();
                          UserModel currentU = currentUser.data;
                          currentU.weight = _weightController.text;
                          currentU.height = _heightController.text;
                          db.setUser(currentU);
                        }

                        Navigator.of(context)
                            .pushReplacementNamed(Routes.gender);
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
    );
  }
}
