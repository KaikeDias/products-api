// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String password;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? password,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Map<String, dynamic> toMapWithoutPassword() {
    final map = toMap();
    map.remove('password');
    map['password'] = '*' * password.length;
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(username: $username, email: $email, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ password.hashCode;
}
