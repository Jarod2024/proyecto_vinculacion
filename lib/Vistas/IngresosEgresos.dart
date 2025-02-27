import 'package:flutter/material.dart';

class IngresosEgresos extends StatefulWidget {
  const IngresosEgresos({super.key});

  @override
  State<IngresosEgresos> createState() => _IngresosEgresosState();
}

class _IngresosEgresosState extends State<IngresosEgresos> {
  bool mostrarIngresos = false;
  bool mostrarEgresos = false;

  final List<Map<String, dynamic>> ingresos = [
    {"nombre": "Cuotas comunitarias", "icono": Icons.account_balance, "valor": TextEditingController()},
    {"nombre": "Eventos solidarios", "icono": Icons.event, "valor": TextEditingController()},
    {"nombre": "Microemprendimientos", "icono": Icons.business, "valor": TextEditingController()},
    {"nombre": "Donaciones", "icono": Icons.volunteer_activism, "valor": TextEditingController()},
    {"nombre": "Alianzas estratégicas", "icono": Icons.handshake, "valor": TextEditingController()},
  ];

  final List<Map<String, dynamic>> egresos = [
    {"nombre": "Costos de electricidad", "icono": Icons.electric_bolt, "valor": TextEditingController()},
    {"nombre": "Costos de agua", "icono": Icons.water_drop, "valor": TextEditingController()},
    {"nombre": "Contrato de servicios", "icono": Icons.receipt, "valor": TextEditingController()},
  ];

  void guardarDatos() {
    for (var item in ingresos) {
      print("${item["nombre"]}: ${item["valor"].text}");
    }
    for (var item in egresos) {
      print("${item["nombre"]}: ${item["valor"].text}");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Datos guardados con éxito")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.teal],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildCheckboxTile('Ingresos', mostrarIngresos, (value) {
                          setState(() => mostrarIngresos = value);
                        }, Icons.trending_up),

                        if (mostrarIngresos) _buildList(ingresos),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Image.asset(
                            'assets/imagenes/IngresosEgresos.png',
                            width: 350,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),

                        _buildCheckboxTile('Egresos', mostrarEgresos, (value) {
                          setState(() => mostrarEgresos = value);
                        }, Icons.trending_down),

                        if (mostrarEgresos) _buildList(egresos),

                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: guardarDatos,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile(String title, bool value, Function(bool) onChanged, IconData icon) {
    return CheckboxListTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      value: value,
      onChanged: (bool? newValue) {
        onChanged(newValue ?? false);
      },
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Icon(item["icono"], color: Colors.white),
            title: Text(
              item["nombre"],
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: item["valor"],
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "0.00",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
