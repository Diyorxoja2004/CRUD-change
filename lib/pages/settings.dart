// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names, camel_case_types, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/components/box.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final user = FirebaseAuth.instance.currentUser!;
  final usercollection = FirebaseFirestore.instance.collection("Users");

  Future<void> edit(String field) async {
    String Update = "";
    await showDialog(
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "Edit " + field,
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: const TextStyle(color: Colors.grey)),
          onChanged: (value) {
            Update = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(Update);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      context: context,
    );

    if (Update.trim().length > 0) {
      await usercollection.doc(user.email).update({field: Update});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(user.email!)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data?.data();
              if (userData != null && userData is Map<String, dynamic>) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      user.email!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                      ),
                      child: Text(
                        "User info",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Box(
                      text: "username",
                      name: userData["username"],
                      onPressed: () => edit("username"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Box(
                      text: "Last Name",
                      name: userData["last name"],
                      onPressed: () => edit("last name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Box(
                      text: "First Name",
                      name: userData["first name"],
                      onPressed: () => edit("first name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Box(
                      text: "Age",
                      name: userData["age"],
                      onPressed: () => edit("age"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        "For User",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("Invalid user data"),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(), 
              );
            }
          },
        ));
  }
}
