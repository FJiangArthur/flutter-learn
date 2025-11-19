import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.username,
    required super.fullName,
    super.profilePictureUrl,
    super.bio,
    super.followersCount,
    super.followingCount,
    super.postsCount,
    super.followers,
    super.following,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      bio: json['bio'] as String?,
      followersCount: json['followersCount'] as int? ?? 0,
      followingCount: json['followingCount'] as int? ?? 0,
      postsCount: json['postsCount'] as int? ?? 0,
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'fullName': fullName,
      'profilePictureUrl': profilePictureUrl,
      'bio': bio,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
      'followers': followers,
      'following': following,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory UserModel.fromFirebaseUser({
    required String uid,
    required String email,
    required String username,
    required String fullName,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      username: username,
      fullName: fullName,
      createdAt: DateTime.now(),
    );
  }
}
