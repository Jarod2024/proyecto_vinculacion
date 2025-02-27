import 'package:flutter/material.dart';

class IngresosEgresosComunidad extends StatefulWidget {
  const IngresosEgresosComunidad({super.key});

  @override
  State<IngresosEgresosComunidad> createState() => _IngresosEgresosComunidadState();
}

class _IngresosEgresosComunidadState extends State<IngresosEgresosComunidad> {
  bool mostrarIngresos = false;
  bool mostrarEgresos = false;

  final List<Map<String, dynamic>> ingresos = [
  {"nombre": "Salario", "icono": Icons.monetization_on},
  {"nombre": "Emprendimiento", "icono": Icons.business, "negrita": true},
  {"nombre": "Adicionales", "icono": Icons.attach_money},
];

final List<Map<String, dynamic>> egresos = [
  {"nombre": "Alquiler o hipoteca", "icono": Icons.home},
  {"nombre": "Servicios públicos (agua, luz, gas, internet)", "icono": Icons.lightbulb},
  {"nombre": "Alimentación y productos de consumo", "icono": Icons.local_grocery_store},
  {"nombre": "Educación", "icono": Icons.school},
  {"nombre": "Entretenimiento", "icono": Icons.movie, "negrita": true},
  {"nombre": "Transporte", "icono": Icons.directions_bus},
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
                            'assets/Imagenes/IngresosEgresos.png',
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
