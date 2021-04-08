import 'package:flutter/material.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'services/firestore_database.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder(
      {Key key, @required this.builder, @required this.databaseBuilder})
      : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<UserModel>) builder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        final UserModel user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
           */
          return MultiProvider(
            providers: [
              Provider<UserModel>.value(value: user),
              ChangeNotifierProvider<FirestoreDatabase>(
                create: (context) => databaseBuilder(context, user.uid),
              ),
              Provider<FirestoreDatabase>(
                create: (context) => FirestoreDatabase(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
