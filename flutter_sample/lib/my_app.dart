import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sample/auth_widget_builder.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/routes.dart';
import 'package:flutter_sample/services/firestore_database.dart';
import 'package:flutter_sample/ui/first_screen.dart';
import 'package:flutter_sample/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class MyApp extends StatelessWidget {
  MyApp({Key key, this.databaseBuilder}) : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return null;
            //SomethingWentWrong();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return AuthWidgetBuilder(
              databaseBuilder: databaseBuilder,
              builder: (BuildContext context,
                  AsyncSnapshot<UserModel> userSnapshot) {
                return Consumer<AuthProvider>(
                  builder: (_, authProviderRef, __) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.active) {
                      return userSnapshot.hasData &&
                              (authProviderRef.status == Status.Authenticated)
                          ? HomeScreen()
                          : FirstScreen();
                    }

                    return Material(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
        },
      ),
    );
  }
}
