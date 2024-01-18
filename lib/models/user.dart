import 'dart:convert';

class User {
  final String id;
  final String name;
  final String address;
  final String password;
  final String type;
  final String token;
  final String email;
  User(
      {required this.id,
      required this.email,
      required this.address,
      required this.name,
      required this.password,
      required this.token,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'type': type,
      'token': token
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        address: map['address'] ?? '',
        password: map['password'] ?? '',
        type: map['type'] ?? '',
        token: map['token'] ?? '');
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromjson(String source) => User.fromMap(jsonDecode(source));
}
