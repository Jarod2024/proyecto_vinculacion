import 'package:flutter/material.dart';

class PresupuestoMensual extends StatefulWidget {
  const PresupuestoMensual({super.key});

  @override
  State<PresupuestoMensual> createState() => _PresupuestoMensualState();
}

class _PresupuestoMensualState extends State<PresupuestoMensual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.teal], // Fondo azul oscuro
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco del cajón
              borderRadius: BorderRadius.circular(15), // Bordes redondeados
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
                    Expanded(child: _buildColumn('Ingresos')),
                    Container(width: 1, height: 200, color: Colors.grey), // Línea vertical separadora
                    Expanded(child: _buildColumn('Egresos')),
                  ],
                ),
                _buildDivider(),
                _buildInfoRow('Total de Ingresos', '0.00'),
                _buildInfoRow('Total de Egresos', '0.00'),
                _buildDivider(),
                const SizedBox(height: 30),
                const Text(
                  'TOTAL',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                _buildInfoRow('Saldo Disponible', '0.00'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(String title) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 10),
        for (int i = 0; i < 3; i++) // Generar 3 campos
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '$title ${i + 1}: 0.00', // Valor predeterminado
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
}
