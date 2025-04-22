import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_project/Testing/screens/firestore/add_firestore_data.dart';
import 'package:dummy_project/Testing/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final editController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection('users');
  final firestore = FirebaseFirestore.instance
      .collection('users')
      // .limit(1)
      // .where('title', isEqualTo: 'raffay')
      .orderBy('id', descending: true)
      .snapshots();

  @override
  void initState() {
    super.initState();
    // listen();
  }

  void listen() {
    collection
        // .where('title', isEqualTo: 'raffay')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.added) {
          log('Added: ${doc.doc.data()}');
        } else if (doc.type == DocumentChangeType.modified) {
          print('Modified: ${doc.doc.data()}');
        } else if (doc.type == DocumentChangeType.removed) {
          print('Removed: ${doc.doc.data()}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Fire Store List')),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => SignUpScreen()),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: firestore,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final list = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        list[index]['title'],
                      ),
                      subtitle: Text(
                        list[index]['id'] ?? 'hehe',
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('Edit'),
                            onTap: () => showMyDialog(
                                list[index]['title'], list[index]['id']),
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            onTap: () {
                              try {
                                collection.doc(list[index]['id']).delete();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e.toString()),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      // subtitle: Text('This is post ${index + 1}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AddFireStoreData(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (builder) => AlertDialog(
        title: Text('Update'),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Edit Post',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancle'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              collection.doc(id).update(
                {
                  'title': editController.text,
                },
              );
              try {} catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
