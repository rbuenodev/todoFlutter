import 'dart:convert';

import 'package:intl/intl.dart';

enum StatusType { aRealizar, realizado, cancelado, aguardando }

class Todo {
  int? id;
  String description;
  String createdAt;
  String completionDate;
  int status;
  String statusDescription;
  String formattedCreatedAt;
  String formattedCompletionDate;

  Todo({
    this.id = 0,
    required this.description,
    required this.createdAt,
    required this.completionDate,
    required this.status,
    this.statusDescription = "A Realizar",
    this.formattedCompletionDate = "",
    this.formattedCreatedAt = "",
  });

  Todo copyWith({
    int? id,
    String? description,
    String? createdAt,
    String? completionDate,
    int? status,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completionDate: completionDate ?? this.completionDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'createdAt': createdAt,
      'completionDate': completionDate,
      'status': status,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      description: map['description'],
      createdAt: map['createdAt'],
      completionDate: map['completionDate'],
      status: map['status'],
    );
  }

  factory Todo.fromMapFormated(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      description: map['description'],
      createdAt: map['createdAt'],
      completionDate: map['completionDate'],
      status: map['status'],
      statusDescription: getStatus(map['status']),
      formattedCreatedAt: getDateFormated(map['createdAt']),
      formattedCompletionDate: getDateFormated(map['completionDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, description: $description, createdAt: $createdAt, completionDate: $completionDate, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.completionDate == completionDate &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        completionDate.hashCode ^
        status.hashCode;
  }

  void validate() {
    DateTime? initialDate = DateTime.now();
    DateTime? finalDate = DateTime.now();
    if ((createdAt.isNotEmpty) && (DateTime.tryParse(createdAt) != null)) {
      initialDate = DateTime.tryParse(createdAt);
    }
    if ((completionDate.isNotEmpty) &&
        (DateTime.tryParse(completionDate) != null)) {
      finalDate = DateTime.tryParse(completionDate);
    }

    if (finalDate!.compareTo(initialDate!) < 0) {
      throw Exception("Data de inicio não pode ser maior que data de término");
    }

    if (initialDate.compareTo(finalDate) < 0) {
      throw Exception("Data de término não pode ser maior que data de término");
    }
  }

  static String getStatus(int? status) {
    switch (status) {
      case 0:
        return "A Realizar";
      case 1:
        return "Realizado";
      case 2:
        return "Cancelado";
      case 3:
        return "Aguardando Avaliação";
      default:
        return "A Realizar";
    }
  }

  static String getDateFormated(String? date) {
    if (date != null) {
      return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
    }
    return "";
  }
}
