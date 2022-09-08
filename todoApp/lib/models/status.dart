import 'dart:convert';

class Status {
  int id;
  String description;
  Status({
    required this.id,
    required this.description,
  });

  Status copyWith({
    int? id,
    String? description,
  }) {
    return Status(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) => Status.fromMap(json.decode(source));

  @override
  String toString() => 'Status(id: $id, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Status &&
        other.id == id &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode;
}
