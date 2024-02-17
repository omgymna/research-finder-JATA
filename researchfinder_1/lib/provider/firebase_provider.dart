import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class FirebaseProvider extends ChangeNotifier {
    List<UserModel> users = [];

    List<UserModel> getAllUsers() {
      FirebaseFirestore.instance
        .collection('users')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
          this.users = users.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
      });
      return users;
    }

}