import 'package:cloud_firestore/cloud_firestore.dart';

class Presupuesto {
  String id;
  String userId;
  List<Map<String, dynamic>> ingresos;
  List<Map<String, dynamic>> egresos;
  double totalIngresos;
  double totalEgresos;
  double saldoFinal;
  DateTime fecha;

  Presupuesto({
    this.id = '',
    required this.userId,
    required this.ingresos,
    required this.egresos,
    required this.totalIngresos,
    required this.totalEgresos,
    required this.saldoFinal,
    required this.fecha,
  });

  // Convertir a JSON para Firebase
  Map<String, dynamic> toJson() {
    return {
       'id': id,
      'userId': userId,
      'ingresos': ingresos,
      'egresos': egresos,
      'totalIngresos': totalIngresos,
      'totalEgresos': totalEgresos,
      'saldoFinal': saldoFinal,
      'fecha': Timestamp.fromDate(fecha),
    };
  }

  // Crear objeto desde Firebase
  factory Presupuesto.fromJson(Map<String, dynamic> json, String id) {
    return Presupuesto(
      id: json['id'],
      userId: json['userId'],
      ingresos: List<Map<String, dynamic>>.from(json['ingresos']),
      egresos: List<Map<String, dynamic>>.from(json['egresos']),
      totalIngresos: (json['totalIngresos'] as num).toDouble(),
      totalEgresos: (json['totalEgresos'] as num).toDouble(),
      saldoFinal: (json['saldoFinal'] as num).toDouble(),
      fecha: (json['fecha'] as Timestamp).toDate(),
    );
  }
}
