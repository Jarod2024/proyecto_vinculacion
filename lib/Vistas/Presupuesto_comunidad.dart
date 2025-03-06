import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_vinculacion/Modelos/presupuesto_comunidad_model.dart';
import '../Servicios/presupuesto_comun_service.dart';

class PresupuestoCompleto extends StatefulWidget {
  final List<Map<String, dynamic>> ingresos;
  final List<Map<String, dynamic>> egresos;
  final List<Map<String, dynamic>> ahorros;
  final List<Map<String, dynamic>> inversiones;

  const PresupuestoCompleto({
    super.key,
    required this.ingresos,
    required this.egresos,
    required this.ahorros,
    required this.inversiones,
  });

  @override
  State<PresupuestoCompleto> createState() => _PresupuestoCompletoState();
}

class _PresupuestoCompletoState extends State<PresupuestoCompleto> {
  List<Map<String, dynamic>> ingresos = [];
  List<Map<String, dynamic>> egresos = [];
  List<Map<String, dynamic>> ahorros = [];
  List<Map<String, dynamic>> inversiones = [];

  @override
  void initState() {
    super.initState();
    ingresos = List.from(widget.ingresos);
    egresos = List.from(widget.egresos);
    ahorros = List.from(widget.ahorros);
    inversiones = List.from(widget.inversiones);
  }

  @override
  Widget build(BuildContext context) {
    double totalIngresos = _calcularTotal(ingresos);
    double totalEgresos = _calcularTotal(egresos);
    double totalAhorros = _calcularTotal(ahorros);
    double totalInversiones = _calcularTotal(inversiones);
    double saldoDisponible = totalIngresos - (totalEgresos + totalAhorros + totalInversiones);

    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCategorySection('Ingresos', ingresos, Colors.green),
            _buildCategorySection('Egresos', egresos, Colors.red),
            _buildCategorySection('Ahorros', ahorros, Colors.blue),
            _buildCategorySection('Inversiones', inversiones, Colors.orange),
            const SizedBox(height: 20),
            _buildSaldoCard(saldoDisponible),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _guardarEnBaseDeDatos(context, totalIngresos, totalEgresos, totalAhorros, totalInversiones, saldoDisponible),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Guardar Presupuesto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Crea una sección desplegable para cada categoría con su lista de elementos y total
  Widget _buildCategorySection(String title, List<Map<String, dynamic>> items, Color color) {
    double total = _calcularTotal(items);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        subtitle: Text("Total: \$${total.toStringAsFixed(2)}"),
        children: items.map((item) {
          double value = double.tryParse(item["valor"].text) ?? 0.0;
          return ListTile(
            title: Text(item["nombre"]),
            trailing: Text("\$${value.toStringAsFixed(2)}"),
          );
        }).toList(),
      ),
    );
  }

  /// Muestra la tarjeta con el saldo disponible
  Widget _buildSaldoCard(double saldo) {
    return Card(
      elevation: 5,
      color: saldo >= 0 ? Colors.green : Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: const Text(
          'Saldo Disponible',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        trailing: Text(
          '\$${saldo.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  /// Calcula el total de una lista de elementos financieros
  double _calcularTotal(List<Map<String, dynamic>> items) {
    return items.fold(0, (sum, item) {
      double value = double.tryParse(item["valor"].text) ?? 0.0;
      return sum + value;
    });
  }

  /// Guarda los datos en Firebase
  Future<void> _guardarEnBaseDeDatos(BuildContext context, double totalIngresos, double totalEgresos, double totalAhorros, double totalInversiones, double saldoDisponible) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      PresupuestoComunidad nuevoPresupuesto = PresupuestoComunidad(
        userId: user.email!,
        ingresos: ingresos.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        egresos: egresos.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        ahorros: ahorros.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        inversiones: inversiones.map((e) => {"nombre": e["nombre"], "valor": e["valor"].text}).toList(),
        totalIngresos: totalIngresos,
        totalEgresos: totalEgresos,
        totalAhorros: totalAhorros,
        totalInversiones: totalInversiones,
        saldoFinal: saldoDisponible,
        fecha: DateTime.now(),
      );

      await PresupuestoService().agregarPresupuesto(nuevoPresupuesto);
      // Limpiar los campos después de guardar
      setState(() {
        ingresos.clear();
        egresos.clear();
        ahorros.clear();
        inversiones.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Presupuesto guardado exitosamente")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar: $e")),
      );
    }
  }
  @override
void didUpdateWidget(covariant PresupuestoCompleto oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.ingresos != widget.ingresos ||
      oldWidget.egresos != widget.egresos ||
      oldWidget.ahorros != widget.ahorros ||
      oldWidget.inversiones != widget.inversiones) {
    setState(() {
      ingresos = List.from(widget.ingresos);
      egresos = List.from(widget.egresos);
      ahorros = List.from(widget.ahorros);
      inversiones = List.from(widget.inversiones);
    });
  }
}

}
