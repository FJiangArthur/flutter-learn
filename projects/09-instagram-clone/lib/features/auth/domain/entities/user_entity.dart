import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String username;
  final String fullName;
  final String? profilePictureUrl;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final List<String> followers;
  final List<String> following;
  final DateTime createdAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    required this.fullName,
    this.profilePictureUrl,
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.followers = const [],
    this.following = const [],
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        username,
        fullName,
        profilePictureUrl,
        bio,
        followersCount,
        followingCount,
        postsCount,
        followers,
        following,
        createdAt,
      ];

  UserEntity copyWith({
    String? uid,
    String? email,
    String? username,
    String? fullName,
    String? profilePictureUrl,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    List<String>? followers,
    List<String>? following,
    DateTime? createdAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
