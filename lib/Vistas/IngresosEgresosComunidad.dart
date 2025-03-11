import 'package:flutter/material.dart';

class IngresosEgresosComunidad extends StatefulWidget {
  final TabController tabController;
  final Function(List<Map<String, dynamic>>, List<Map<String, dynamic>>, List<Map<String,dynamic>>, List<Map<String, dynamic>>) onCalcular;

  const IngresosEgresosComunidad({super.key, required this.tabController, required this.onCalcular});
  @override
  State<IngresosEgresosComunidad> createState() => _IngresosEgresosComunidadState();
}

class _IngresosEgresosComunidadState extends State<IngresosEgresosComunidad> {
  bool mostrarIngresos = false;
  bool mostrarEgresos = false;
  bool mostrarAhorros = false;
  bool mostrarInversiones = false;
  
  final List<Map<String, dynamic>> ingresos = [
    {"nombre": "Salario", "icono": Icons.monetization_on},
    {"nombre": "Emprendimiento", "icono": Icons.business, "negrita": true},
    {"nombre": "Adicionales", "icono": Icons.attach_money},
  ];

  final List<Map<String, dynamic>> egresos = [
    {"nombre": "Alquiler o hipoteca", "icono": Icons.home},
    {"nombre": "Servicios públicos", "icono": Icons.lightbulb},
    {"nombre": "Alimentación", "icono": Icons.local_grocery_store},
    {"nombre": "Educación", "icono": Icons.school},
    {"nombre": "Entretenimiento", "icono": Icons.movie, "negrita": true},
    {"nombre": "Transporte", "icono": Icons.directions_bus},
  ];

  final List<Map<String, dynamic>> ahorros = [
    {"nombre": "Cuenta de ahorros", "icono": Icons.savings},
    {"nombre": "Fondo de emergencia", "icono": Icons.security},
  ];

  final List<Map<String, dynamic>> inversiones = [
    {"nombre": "Acciones", "icono": Icons.trending_up},
    {"nombre": "Bienes raíces", "icono": Icons.real_estate_agent},
  ];

  void guardarDatos() {
    for (var item in [...ingresos, ...egresos, ...ahorros, ...inversiones]) {
      debugPrint("${item["nombre"]}: ${item["valor"]?.text ?? "0.00"}");
    }
    widget.onCalcular(ingresos, egresos,ahorros,inversiones);
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

                        _buildCheckboxTile('Ahorros', mostrarAhorros, (value) {
                          setState(() => mostrarAhorros = value);
                        }, Icons.savings),
                        if (mostrarAhorros) _buildList(ahorros),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Image.asset(
                            'assets/imagenes/ahorro_inversion.jpg',
                            width: 350,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                        _buildCheckboxTile('Inversiones', mostrarInversiones, (value) {
                          setState(() => mostrarInversiones = value);
                        }, Icons.pie_chart),
                        if (mostrarInversiones) _buildList(inversiones),

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
        item["valor"] ??= TextEditingController();
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
