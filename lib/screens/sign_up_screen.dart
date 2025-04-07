import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/components/custom_button.dart';
import 'package:dummy_project/components/input_field.dart';
import 'package:dummy_project/components/pass_strength_indicator.dart';
import 'package:dummy_project/components/password_field.dart';
import 'package:dummy_project/components/password_requirements.dart';
import 'package:dummy_project/components/term_and_privacy_text.dart';
import 'package:dummy_project/screens/create_account_screen/create_account_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   String role = 'Parent';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             spacing: 20,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('This is Sign Up Screen'),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(hintText: 'Email'),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(hintText: 'Password'),
//               ),
//               DropdownButtonFormField(
//                 value: 'Parent',
//                 items: [
//                   DropdownMenuItem(
//                     value: 'Parent',
//                     child: Text('Parent'),
//                   ),
//                   DropdownMenuItem(
//                     value: 'Child',
//                     child: Text('Child'),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   role = value.toString();
//                 },
//                 decoration: InputDecoration(hintText: 'Select Role'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   print(role);
//                   // try {
//                   //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
//                   //     email: emailController.text,
//                   //     password: passwordController.text,
//                   //   );
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(builder: (builder) => HomeScreen()),
//                   //   );
//                   // } catch (e) {
//                   //   ScaffoldMessenger.of(
//                   //     context,
//                   //   ).showSnackBar(SnackBar(content: Text(e.toString())));
//                   // }
//                 },
//                 child: const Text('Sign Up'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (builder) => LoginScreen()),
//                   );
//                 },
//                 child: Text('hehe '),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;
  String _passwordStrength = 'weak';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updatePasswordStrength);
  }

  void _updatePasswordStrength() {
    // Simple password strength check logic
    final password = _passwordController.text;
    setState(() {
      if (password.length >= 8 &&
          (password.contains(RegExp(r'[0-9]')) ||
              password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) &&
          !password.contains(' ')) {
        _passwordStrength = 'strong';
      } else if (password.length >= 8) {
        _passwordStrength = 'medium';
      } else {
        _passwordStrength = 'weak';
      }
    });
    log('Password strength: $_passwordStrength');
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordStrength);
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        elevation: 0,
        // backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InputField(
                    hintText: 'First name',
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 12),
                  InputField(
                    hintText: 'Last name',
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 12),
                  InputField(
                    hintText: 'Phone number',
                    keyboardType: TextInputType.phone,
                    controller: _phNumberController,
                  ),
                  const SizedBox(height: 12),
                  InputField(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 12),
                  PasswordField(
                    controller: _passwordController,
                    isPasswordVisible: _isPasswordVisible,
                    togglePasswordVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  PasswordStrengthIndicator(strength: _passwordStrength),
                  const SizedBox(height: 4),
                  PasswordRequirements(
                    password: _passwordController.text,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TermsAndPrivacyText(),
                  const SizedBox(height: 16),
                  CustomButton(
                    onPressed: () async {
                      if (_passwordStrength != 'strong') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter a strong password'),
                          ),
                        );
                        return;
                      }
                      final user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                      if (user.user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.user!.uid)
                            .set({
                          'uid': user.user!.uid,
                          'firstName': _firstNameController.text,
                          'lastName': _lastNameController.text,
                          'phoneNumber': _phNumberController.text,
                          'email': _emailController.text,
                        }).then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileInfoScreen(),
                            ),
                          );
                        }).onError((error, trace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sign up failed'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
