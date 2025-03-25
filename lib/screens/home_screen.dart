import 'package:dummy_project/screens/login_screen.dart';
import 'package:dummy_project/screens/post_screen/add_post.dart';
import 'package:dummy_project/screens/sign_up_screen.dart';
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
        children: [
          // Expanded(
          //   child: FirebaseAnimatedList(
          //       query: ref,
          //       itemBuilder: (context, snapshot, animation, index) {
          //         return ListTile(
          //           title: Text(snapshot.child('title').value.toString()),
          //           subtitle: Text('This is post ${index + 1}'),
          //         );
          //       }),
          // ),
          Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = map.values.toList();

                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(list[index]['title']),
                            subtitle: Text(list[index]['time']),
                            // subtitle: Text('This is post ${index + 1}'),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => AddPost()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
