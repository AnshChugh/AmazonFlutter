// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String address;
  final String password;
  final String type;
  final String token;
  final String email;
  final List<dynamic> cart;
  User(
      {required this.id,
      required this.email,
      required this.address,
      required this.name,
      required this.password,
      required this.token,
      required this.type,
      required this.cart});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'type': type,
      'token': token,
      'cart':cart,
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
        token: map['token'] ?? '',
        cart:  List<Map<String,dynamic>>.from(map['cart']?.map((x) => Map<String,dynamic>.from(x))));
  }

  String toJson() => jsonEncode(toMap());

  factory User.fromjson(String source) => User.fromMap(jsonDecode(source));


  User copyWith({
    String? id,
    String? name,
    String? address,
    String? password,
    String? type,
    String? token,
    String? email,
    List<dynamic>? cart,
  }) {
    return User(
      id:id ?? this.id,
      name:name ?? this.name,
      address:address ?? this.address,
      password:password ?? this.password,
      type:type ?? this.type,
      token:token ?? this.token,
      email:email ?? this.email,
      cart:cart ?? this.cart,
    );
  }
}
