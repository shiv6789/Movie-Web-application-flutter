import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String email;
  final List<String> privateMovies;
  final List<String> publicMovies;
  UserModel({
    required this.id,
    required this.email,
    required this.privateMovies,
    required this.publicMovies,
  });

  UserModel copyWith({
    String? id,
    String? email,
    List<String>? privateMovies,
    List<String>? publicMovies,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      privateMovies: privateMovies ?? this.privateMovies,
      publicMovies: publicMovies ?? this.publicMovies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'privateMovies': privateMovies,
      'publicMovies': publicMovies,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      privateMovies: List<String>.from(map['privateMovies']),
      publicMovies: List<String>.from(map['publicMovies']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, privateMovies: $privateMovies, publicMovies: $publicMovies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        listEquals(other.privateMovies, privateMovies) &&
        listEquals(other.publicMovies, publicMovies);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        privateMovies.hashCode ^
        publicMovies.hashCode;
  }
}
