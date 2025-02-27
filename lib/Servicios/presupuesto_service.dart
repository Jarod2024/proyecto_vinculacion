import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Modelos/presupuesto_model.dart';

class PresupuestoService {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _presupuestoCollection =
      FirebaseFirestore.instance.collection('Presupuestos');

  PresupuestoService() {
    if (user == null) {
      debugPrint('Usuario no autenticado');
      return;
    }
  }

 // Agregar un nuevo presupuesto y devolver el ID generado
  Future<String> agregarPresupuesto(Presupuesto presupuesto) async {
    DocumentReference docRef = await _presupuestoCollection.add(presupuesto.toJson());
    return docRef.id; // Devolver el ID del nuevo documento
  }

  /// **Obtener todos los presupuestos**
  Stream<List<Presupuesto>> obtenerPresupuestos() {
    return _presupuestoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Presupuesto.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  /// **Actualizar un presupuesto**
  Future<void> actualizarPresupuesto(String id, Presupuesto presupuesto) async {
    try {
      await _presupuestoCollection.doc(id).update(presupuesto.toJson());
    } catch (e) {
      debugPrint('Error al actualizar presupuesto: $e');
      rethrow;
    }
  }

  /// **Eliminar un presupuesto**
  Future<void> eliminarPresupuesto(String id) async {
    try {
      await _presupuestoCollection.doc(id).delete();
    } catch (e) {
      debugPrint('Error al eliminar presupuesto: $e');
      rethrow;
    }
  }
}
