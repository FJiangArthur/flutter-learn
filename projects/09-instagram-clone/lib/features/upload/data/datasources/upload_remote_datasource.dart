import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UploadRemoteDataSource {
  // TODO: Implement upload data source methods
}

class UploadRemoteDataSourceImpl implements UploadRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;

  UploadRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseStorage,
    required this.firebaseAuth,
  });
}
