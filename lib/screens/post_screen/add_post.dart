import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
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
                await databaseRef
                    .child(DateTime.now().microsecondsSinceEpoch.toString())
                    .set({
                  'title': postController.text,
                  'time': DateTime.now().toIso8601String(),
                });
                // postController.clear();
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
