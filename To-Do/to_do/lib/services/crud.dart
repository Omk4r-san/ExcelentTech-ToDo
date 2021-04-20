import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addTask(noteData, String collection) async {
    Firestore.instance.collection(collection).add(noteData).catchError((e) {
      print(e);
    });
  }

  Future<Stream> getData(String collection) async {
    Stream result = await Firestore.instance.collection(collection).snapshots();
    return result;
  }

  deleteData(noteId, String collection) async {
    return Firestore.instance
        .collection(collection)
        .document(noteId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
