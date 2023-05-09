// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class ProductDTO {
  final int? id;
  final String? name;
  final List<String> tags;

  ProductDTO({
    this.id,
    this.name,
    required this.tags,
  });

  ProductDTO copyWith({
    int? id,
    String? name,
    List<String>? tags,
  }) {
    return ProductDTO(
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

  factory ProductDTO.fromMap(Map<String, dynamic> map) {
    return ProductDTO(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      tags: (map['tags'] != null && map['tags'] is List)
          ? List<String>.from(map['tags'] as List)
          : <String>[],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDTO.fromJson(String source) =>
      ProductDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductDTO(id: $id, name: $name, tags: $tags)';

  @override
  bool operator ==(covariant ProductDTO other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && other.name == name && listEquals(other.tags, tags);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ tags.hashCode;
}
