import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/auth/firestore.dart';
import 'package:test1/components/drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user =  FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Main()
    );
  }
}






class Main extends StatefulWidget {

  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  

  final TextEditingController _textcontroller = TextEditingController();
  final FirestoreService _firestoreService =FirestoreService();

  void openBoxNotes({String? docID}){
    showDialog(context: context, builder: (context)=> AlertDialog(
      content: TextField(
        controller: _textcontroller,
      ),
      actions: [
        ElevatedButton(
          onPressed: (){
            //add new number
           if(docID == null){
             _firestoreService.addnote(_textcontroller.text);
           }
           else{
            _firestoreService.updateNote(docID, _textcontroller.text);
           }
            //clear all
            _textcontroller.clear();
            //back to page
            Navigator.pop(context);
          },
          child:const Text("Add"),
          
        )
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         drawer:  const MYDRAW(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text("Notes",style: TextStyle(color: Colors.white),),
        centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        onPressed:openBoxNotes,
        child:const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getNoteStream(),
        builder: (context,snapshot){
          if(snapshot.hasData){
           List noteslist = snapshot.data!.docs;
            
            //display as list
            return ListView.builder(
              itemCount: noteslist.length,
              itemBuilder: (context,index){

                //get each doc
                DocumentSnapshot document = noteslist[index];
                String docID = document.id;

                Map<String,dynamic> data = document.data()
                as Map<String ,dynamic>;
                String? noteText = data["notes"] ;

                //display as list
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: Text(noteText!,style: const TextStyle(color: Colors.black,fontSize: 20),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //update
                          IconButton(
                        onPressed: ()=>openBoxNotes(docID : docID),
                        icon: const Icon(Icons.settings),
                      ),
                      //delete
                      IconButton(
                        onPressed: ()=>_firestoreService.deleteNote(docID),
                        icon: const Icon(Icons.delete),
                      ),
                        ],
                      )
                    ),
                  ),
                );
              },
            );
          }
          else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
              }
          else{
            return const Text("No notes...");
          }
        },
       
      ),
    );
  }
}