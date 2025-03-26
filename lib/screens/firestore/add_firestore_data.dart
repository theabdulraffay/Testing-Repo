import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddFireStoreData extends StatefulWidget {
  const AddFireStoreData({super.key});

  @override
  State<AddFireStoreData> createState() => _AddFireStoreDataState();
}

class _AddFireStoreDataState extends State<AddFireStoreData> {
  final postController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Firestore Data')),
      body: Column(
        spacing: 30,
        children: [
          TextFormField(
            controller: postController,
            decoration: InputDecoration(
              hintText: 'What is in your mind?',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          ElevatedButton(
            onPressed: () async {
              // Add post to firebase

              try {
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                try {
                  firestore.doc(id).set({
                    'id': id,
                    'title': postController.text,
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }

                // postController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
