import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/screens/product_registration_screen/product_registration_screen.dart';
import 'package:dummy_project/screens/sign_up_screen/components/custom_button.dart';
import 'package:dummy_project/screens/create_account_screen/components/birthday_picker.dart';
import 'package:dummy_project/screens/create_account_screen/components/gender_selector.dart';
import 'package:dummy_project/screens/create_account_screen/components/header_section.dart';
import 'package:dummy_project/screens/create_account_screen/components/page_indicator.dart';
import 'package:dummy_project/screens/create_account_screen/components/section_title.dart';
import 'package:dummy_project/screens/create_account_screen/components/skin_type_selector.dart';
import 'package:dummy_project/screens/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileInfoScreen extends StatefulWidget {
  const UserProfileInfoScreen({super.key});

  @override
  State<UserProfileInfoScreen> createState() => _UserProfileInfoScreenState();
}

class _UserProfileInfoScreenState extends State<UserProfileInfoScreen> {
  String? selectedSkinType;
  String? selectedGender;
  DateTime? selectedBirthday;
  final TextEditingController _birthdayController = TextEditingController();
  final List<String> skinTypes = [
    'Oily',
    'Dry',
    'Normal',
    'Scaly',
    'Sensitive',
    'Other'
  ];
  final List<String> genders = ['Female', 'Male', 'Other'];
  int currentPage = 0;
  final int totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((_) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error signing out: $error')),
                );
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderSection(
              title: 'Tell us about you',
              subtitle: 'This will help us personalize your experience.',
            ),
            const SizedBox(height: 24),

            // Skin Type Section
            const SectionTitle(title: 'What\'s your skin type?'),
            const SizedBox(height: 12),
            SkinTypeSelector(
              skinTypes: skinTypes,
              selectedSkinType: selectedSkinType,
              onSkinTypeSelected: (skinType) {
                setState(() {
                  selectedSkinType = skinType;
                });
              },
            ),
            const SizedBox(height: 24),

            // Gender Section
            const SectionTitle(title: 'What is your gender?'),
            const SizedBox(height: 12),
            GenderSelector(
              genders: genders,
              selectedGender: selectedGender,
              onGenderSelected: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            const SizedBox(height: 24),

            // Birthday Section
            const SectionTitle(title: 'What is your birthday?'),
            const SizedBox(height: 12),
            BirthdayPicker(
              controller: _birthdayController,
              onDateSelected: (date) {
                setState(() {
                  selectedBirthday = date;
                });
              },
            ),

            const Spacer(),

            // Page Indicator
            PageIndicator(currentPage: currentPage, totalPages: totalPages),
            const SizedBox(height: 16),

            // Continue Button
            CustomButton(
              text: 'Continue',
              onPressed: () async {
                if (selectedSkinType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a skin type')),
                  );
                } else if (selectedGender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Select Gender')));
                } else if (selectedBirthday == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Select Birthday')));
                } else {
                  final id = FirebaseAuth.instance.currentUser?.uid;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(id)
                      .update({
                    'skinType': selectedSkinType,
                    'gender': selectedGender,
                    'birthday': selectedBirthday,
                  }).then((onValue) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductRegistrationScreen(),
                      ),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
