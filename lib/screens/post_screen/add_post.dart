import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post')),
      body: Column(
        spacing: 30,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'What is in your mind?',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),

          ElevatedButton(
            onPressed: () {
              // Add post to firebase
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
