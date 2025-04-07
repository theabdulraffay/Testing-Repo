import 'package:dummy_project/screens/create_account_screen/create_account_screen.dart';
import 'package:dummy_project/screens/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenService {
  SplashScreenService({required this.context});
  BuildContext context;
  final instance = FirebaseAuth.instance;

  Future<void> getCurrentuser() async {
    final user = instance.currentUser;
    if (user != null) {
      // user.uid;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => UserProfileInfoScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => SignUpScreen()),
      );
    }
  }
}
