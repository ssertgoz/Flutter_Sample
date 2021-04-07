import 'package:flutter/material.dart';
import 'package:flutter_sample/ui/auth/email_log_in_screen.dart';
import 'package:flutter_sample/ui/auth/email_sign_up_screen.dart';
import 'package:flutter_sample/ui/auth/log_in_screen.dart';
import 'package:flutter_sample/ui/auth/sign_up_screen.dart';
import 'package:flutter_sample/ui/first_screen.dart';
import 'package:flutter_sample/ui/home/home_screen.dart';

import 'package:flutter_sample/ui/motivation_screen.dart';
import 'package:flutter_sample/ui/gender_screen.dart';
import 'package:flutter_sample/ui/physical_screen.dart';

import 'ui/name_and_surname.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login = '/login';
  static const String elogin = '/elogin';
  static const String signup = '/signup';
  static const String esignup = '/esignup';
  static const String home = '/home';
  static const String first = '/first';
  static const String name = '/name';
  static const String motivation = '/motivation';
  static const String physical = '/physical';
  static const String gender = '/gender';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LogInScreen(),
    elogin: (BuildContext context) => EmailLogInScreen(),
    signup: (BuildContext context) => SignUpScreen(),
    esignup: (BuildContext context) => EmailSignUpScreen(),
    home: (BuildContext context) => HomeScreen(),
    first: (BuildContext context) => FirstScreen(),
    name: (BuildContext context) => NameSurnameScreen(),
    gender: (BuildContext context) => GenderScreen(),
    physical: (BuildContext context) => PhysicalScreen(),
    motivation: (BuildContext context) => MotivationScreen(),
  };
}
