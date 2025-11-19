import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FeedRemoteDataSource {
  // TODO: Implement feed data source methods
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FeedRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });
}
