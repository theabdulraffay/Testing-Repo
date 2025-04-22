import 'package:dummy_project/Testing/screens/firestore/firestore_list_screen.dart';
// import 'package:dummy_project/screens/home_screen.dart';
import 'package:dummy_project/Testing/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenService {
  SplashScreenService({required this.context});
  BuildContext context;
  final instance = FirebaseAuth.instance;

  Future<void> getCurrentuser() async {
    final user = instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => FirestoreListScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => SignUpScreen()),
      );
    }
  }
}
