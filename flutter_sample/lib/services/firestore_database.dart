import 'package:flutter/material.dart';
import 'package:flutter_sample/models/user_model.dart';

import 'firebase_path.dart';
import 'firebase_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase extends ChangeNotifier {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Method to create/update userModel
  Future<UserModel> setUser(UserModel user) async {
    await _firestoreService.setData(
      path: uid,
      data: user.toMap(),
    );
    return user;
  }

  //Method to delete userModel entry
  Future<void> deleteUser(UserModel user) async {
    await _firestoreService.deleteData(path: FirestorePath.user(uid));
  }

  //Method to retrieve todoModel object based on the given todoId
  Stream<UserModel> userStream({@required String uid}) =>
      _firestoreService.documentStream(
        path: FirestorePath.user(uid),
        builder: (data, uid) => UserModel.fromMap(data, uid),
      );

  //Method to retrieve all todos item from the same user based on uid
  Stream<List<UserModel>> usersStream() => _firestoreService.collectionStream(
        path: FirestorePath.users(),
        builder: (data, documentId) => UserModel.fromMap(data, documentId),
      );
}
