
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/settings.dart';


class MYDRAW extends StatelessWidget {
  const MYDRAW({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100,),
         const Padding(
           padding: EdgeInsets.all(8.0),
           child: ListTile(
              title: Text("HOME",style: TextStyle(color: Colors.black),),
              leading: Icon(Icons.home,color: Colors.black,),
            ),
         ) ,
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListTile(
              title: const Text("SETTINGS",style: TextStyle(color: Colors.black),),
              leading: const Icon(Icons.settings,color: Colors.black,),
              onTap: (){
                Navigator.pop(context);

                Navigator.push(context,MaterialPageRoute(builder: (context)=> const settings()) );},
            ),
         ) ,
        
         Padding(
           padding: const EdgeInsets.only(bottom: 25,left: 25),
           child: ListTile(title: const Text("LOG OUT",style: TextStyle(color: Colors.black),),
           leading: const Icon(Icons.logout,color: Colors.black,),
           onTap:(){FirebaseAuth.instance.signOut();},
          )
         )
        ],
      ),
    );
  }
}