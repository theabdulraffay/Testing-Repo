import 'package:dummy_project/Testing/screens/post_screen/add_post.dart';
import 'package:dummy_project/Testing/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home Screen')),
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  final id = snapshot.child('id').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(title),
                      subtitle: Text(id),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title, id);
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                              onTap: () async {
                                await ref.child(id).remove().then(
                                  (value) {
                                    Navigator.pop(context);
                                  },
                                ).onError((error, trace) {});
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchFilter.text.toLowerCase())) {
                    return ListTile(
                      title: Text(title),
                      subtitle: Text('This is post ${index + 1}'),
                    );
                  }
                  return SizedBox();
                }),
          ),
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       if (snapshot.hasData) {
          //         Map<dynamic, dynamic> map =
          //             snapshot.data!.snapshot.value as dynamic;
          //         List<dynamic> list = map.values.toList();
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(
          //                 list[index]['title'],
          //               ),
          //               subtitle: Text(
          //                 list[index]['time'],
          //               ),
          //               // subtitle: Text('This is post ${index + 1}'),
          //             );
          //           },
          //         );
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => AddPost(),
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
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Edit Post',
              border: OutlineInputBorder(),
            ),
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
              try {
                await ref.child(id).update(
                  {
                    'title': editController.text,
                  },
                );
              } catch (e) {
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
