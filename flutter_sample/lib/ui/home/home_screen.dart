import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              authProvider.signOut();
              Navigator.of(context).pushReplacementNamed(Routes.first);
            },
            child: Text("Sign out"),
          ),
        ),
      ),
    );
  }
}
