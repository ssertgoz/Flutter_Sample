import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/constants/constants.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../services/firestore_database.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    FirestoreDatabase db =
        FirestoreDatabase(uid: authProvider.currentUser().uid);
    return StreamBuilder(
        stream: db.userStream(uid: authProvider.currentUser().uid),
        builder: (context, currentUser) => Scaffold(
              body: Padding(
                padding: EdgeInsets.only(top: 150, left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        """Merhaba ${currentUser.data.name}, Güncel kilon ${currentUser.data.weight}""",
                        style:
                            TextStyle(color: primaryGreenColor, fontSize: 25),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 200,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryGreenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)))),
                        onPressed: () {
                          authProvider.signOut();
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.first);
                        },
                        child: Text(
                          "Sign out",
                          style:
                              TextStyle(color: primaryWhiteColor, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Business',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Account',
                  ),
                ],
                //currentIndex: _selectedIndex,
                selectedItemColor: primaryGreenColor,
                // onTap: _onItemTapped,
              ),
            ));
  }
}
