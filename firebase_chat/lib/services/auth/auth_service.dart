import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class AuthService extends ChangeNotifier{
  //instance of auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instance of firebase store

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //sign user in
  Future<UserCredential> signInWithEmailandPassword(String email, String password,) async {
    try{
      //sign in
      UserCredential userCredential = 
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password, 
      );
      //add new document if not already existing
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
              'uid' : userCredential.user!.uid,
              'email' : email,
          },SetOptions(merge: true));

      return userCredential;
    } 
    //catch any errors
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }
  //create new user
  Future<UserCredential> signUpWithEmailAndPassword(
    String email, password,) async {
      try{
          UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, 
            password: password,
          );
          //after creating user, create document for user in users collection
          _fireStore.collection('users').doc(userCredential.user!.uid).set({
              'uid' : userCredential.user!.uid,
              'email' : email,
          });

          return userCredential;

      } on FirebaseAuthException catch(e){
        throw Exception(e.code);
      }
  }


  //sign user out
  Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
  }
} 