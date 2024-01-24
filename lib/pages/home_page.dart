import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/components/drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user =  FirebaseAuth.instance.currentUser!;

  // List<String> DOCID = [];

  // Future getID()async{
  //   await FirebaseFirestore.instance
  //   .collection("users")
  //   .orderBy("age",descending: true)
  //   .get()
  //   .then((snapshot) => snapshot.docs.forEach((document) { 
  //     DOCID.add(document.reference.id);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  const MYDRAW(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("HOME",style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("Go to the Settings Page"),
          ],
        ),
      ),
    );
  }
}