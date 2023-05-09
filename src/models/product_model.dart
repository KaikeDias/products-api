// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class ProductModel {
  final int id;
  final String name;
  final List<String> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.tags,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    List<String>? tags,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tags': tags,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      tags: List<String>.from(
        (map['tags'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductModel(id: $id, name: $name, tags: $tags)';

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && other.name == name && listEquals(other.tags, tags);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ tags.hashCode;
}
