import 'package:flutter/material.dart';
import 'package:proyecto_vinculacion/Vistas/IngresosEgresos.dart';
import 'package:proyecto_vinculacion/Vistas/Presupuesto.dart';

class AdminComunitaria extends StatefulWidget {
  const AdminComunitaria({super.key});

  @override
  State<AdminComunitaria> createState() => _AdminComunitariaState();
}

class _AdminComunitariaState extends State<AdminComunitaria> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  List<Map<String, dynamic>> ingresos = [];
  List<Map<String, dynamic>> egresos = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void actualizarDatos(List<Map<String, dynamic>> nuevosIngresos, List<Map<String, dynamic>> nuevosEgresos) {
    setState(() {
      ingresos = nuevosIngresos;
      egresos = nuevosEgresos;
    });

    // Cambiar a la pestaña de Presupuesto
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administración Comunitaria (Manejo de costos fijos)"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.shopping_cart), text: "Ingresos y egresos"),
            Tab(icon: Icon(Icons.monetization_on), text: "Presupuesto mensual"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          IngresosEgresos(tabController: _tabController, onCalcular: actualizarDatos),
          PresupuestoMensual(ingresos: ingresos, egresos: egresos),
        ],
      ),
    );
  }
}
