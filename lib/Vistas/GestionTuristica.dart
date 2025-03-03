import 'package:flutter/material.dart';

class TurismoComunitario extends StatefulWidget {
  const TurismoComunitario({super.key});

  @override
  State<TurismoComunitario> createState() => _TurismoComunitarioState();
}

class _TurismoComunitarioState extends State<TurismoComunitario> {
  final Map<String, bool> mostrarCategorias = {
    "Lugar Turístico": false,
    "Registro de visitante": false,
    "Emprendimiento Comunitario Turístico": false,
    "Estrategias para el fortalecimiento del turismo comunitario": false,
  };

  final Map<String, List<Map<String, dynamic>>> categorias = {
    "Lugar Turístico": [
      {"nombre": "Número de registro turístico", "icono": Icons.confirmation_number},
      {"nombre": "Tipo de servicio turístico", "icono": Icons.room_service},
      {"nombre": "Nombre del establecimiento", "icono": Icons.store},
      {"nombre": "Capacidad de atención", "icono": Icons.people},
      {"nombre": "Tarifas por servicio", "icono": Icons.attach_money},
      {"nombre": "Horarios de operación", "icono": Icons.schedule},
      {"nombre": "Ubicación", "icono": Icons.location_on},
    ],
    "Registro de visitante": [
      {"nombre": "Cédula", "icono": Icons.badge},
      {"nombre": "Nombre", "icono": Icons.person},
      {"nombre": "Teléfono", "icono": Icons.phone},
      {"nombre": "Opiniones y valoraciones de visitantes", "icono": Icons.star},
    ],
    "Emprendimiento Comunitario Turístico": [
      {"nombre": "Albergues", "icono": Icons.hotel},
      {"nombre": "Hospedajes rurales", "icono": Icons.house},
      {"nombre": "Rutas de turismo vivencial", "icono": Icons.directions_walk},
      {"nombre": "Experiencias astronómicas autóctonas", "icono": Icons.nightlight},
      {"nombre": "Artesanía local con valor cultural", "icono": Icons.handshake},
      {"nombre": "Productos locales con valor cultural", "icono": Icons.shopping_bag},
      {"nombre": "Patrimonio natural", "icono": Icons.nature},
    ],
    "Estrategias para el fortalecimiento del turismo comunitario": [
      {"nombre": "Programas de formación en gestión de emprendimientos turísticos", "icono": Icons.school},
      {"nombre": "Microcréditos para proyectos comunitarios", "icono": Icons.monetization_on},
      {"nombre": "Financiamiento para proyectos comunitarios", "icono": Icons.account_balance},
      {"nombre": "Estrategias de marketing digital", "icono": Icons.public},
      {"nombre": "Estrategias de turismo experiencial", "icono": Icons.explore},
      {"nombre": "Alianzas con el sector público", "icono": Icons.business},
      {"nombre": "Alianzas con el sector privado", "icono": Icons.handshake},
    ],
  };

  void guardarDatos() {
    for (var categoria in categorias.keys) {
      for (var item in categorias[categoria]!) {
        print("${item["nombre"]}: ${item["valor"]?.text ?? "No ingresado"}");
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Datos guardados con éxito")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: mostrarCategorias.keys.map((categoria) {
                return Column(
                  children: [
                    _buildCheckboxTile(categoria, mostrarCategorias[categoria]!, (value) {
                      setState(() => mostrarCategorias[categoria] = value);
                    }),
                    if (mostrarCategorias[categoria]!) _buildList(categorias[categoria]!),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: guardarDatos,
        backgroundColor: Colors.black,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  Widget _buildCheckboxTile(String title, bool value, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Ingrese...",
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
