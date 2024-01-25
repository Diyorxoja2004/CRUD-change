import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreService{

  //get collection of note
  final CollectionReference notes = 
  FirebaseFirestore.instance.collection('notes');
  //CREATE
  Future<void> addnote(String note){
    return notes.add({
      'notes': note,
      'timestamp': Timestamp.now(),
      }
    );
  }
  
  //READ
  Stream<QuerySnapshot> getNoteStream(){
    final notesStream = 
    notes.orderBy("timestamp",descending: true).snapshots();
    return notesStream;
  }

  //UPDATE
   Future<void> updateNote(String docID, String newNote){
    return notes.doc(docID).update({
      "notes": newNote,
      "timestamp" :Timestamp.now(),
    });
   }

  //DELETE
    Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
   }
}