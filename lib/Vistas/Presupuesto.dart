import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vinculacion/Modelos/presupuesto_model.dart';
import '../Servicios/presupuesto_service.dart';

class PresupuestoMensual extends StatefulWidget {
  final List<Map<String, dynamic>> ingresos;
  final List<Map<String, dynamic>> egresos;

  const PresupuestoMensual({
    super.key,
    required this.ingresos,
    required this.egresos,
  });

  @override
  State<PresupuestoMensual> createState() => _PresupuestoMensualState();
}

class _PresupuestoMensualState extends State<PresupuestoMensual> {
  List<Map<String, dynamic>> ingresos = [];
  List<Map<String, dynamic>> egresos = [];

  @override
  void initState() {
    super.initState();
    ingresos = List.from(widget.ingresos);
    egresos = List.from(widget.egresos);
  }

  @override
  Widget build(BuildContext context) {
    double totalIngresos = _calcularTotal(ingresos);
    double totalEgresos = _calcularTotal(egresos);
    double saldoDisponible = totalIngresos - totalEgresos;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Presupuesto Mensual',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildList('Ingresos', ingresos)),
                    Container(width: 1, height: 200, color: Colors.grey),
                    Expanded(child: _buildList('Egresos', egresos)),
                  ],
                ),
                _buildDivider(),
                _buildInfoRow('Total de Ingresos', totalIngresos.toStringAsFixed(2)),
                _buildInfoRow('Total de Egresos', totalEgresos.toStringAsFixed(2)),
                _buildDivider(),
                const SizedBox(height: 30),
                const Text(
                  'TOTAL',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                _buildInfoRow('Saldo Disponible', saldoDisponible.toStringAsFixed(2)),
                ElevatedButton(
                  onPressed: () => _guardarEnBaseDeDatos(context, totalIngresos, totalEgresos, saldoDisponible),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Guardar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Calcula el total de ingresos o egresos
  double _calcularTotal(List<Map<String, dynamic>> items) {
    return items.fold(0, (sum, item) {
      double value = double.tryParse(item["valor"].text) ?? 0.0;
      return sum + value;
    });
  }

  /// Muestra la lista de ingresos o egresos
  Widget _buildList(String title, List<Map<String, dynamic>> items) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 10),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${item["nombre"]}: ${item["valor"].text.isEmpty ? "0.00" : item["valor"].text}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.grey, thickness: 1, height: 20);
  }

  /// Función para guardar en Firebase
  Future<void> _guardarEnBaseDeDatos(BuildContext context, double totalIngresos, double totalEgresos, double saldoDisponible) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      debugPrint('Usuario autenticado: $user');
      if (user == null) {
        debugPrint('Usuario no autenticado');
        return;
      }

      Presupuesto nuevoPresupuesto = Presupuesto(
        userId: user.email!,
        ingresos: ingresos.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        egresos: egresos.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        totalIngresos: totalIngresos,
        totalEgresos: totalEgresos,
        saldoFinal: saldoDisponible,
        fecha: DateTime.now(),
      );

      await PresupuestoService().agregarPresupuesto(nuevoPresupuesto);

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Presupuesto guardado exitosamente")),
      );

      // Limpiar los campos después de guardar
      setState(() {
        ingresos.clear();
        egresos.clear();
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar: $e")),
      );
    }
  }
}
