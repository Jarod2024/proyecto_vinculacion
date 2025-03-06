import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'admin_eco_familiar.dart';


class MiembroComunidad extends StatefulWidget {
  const MiembroComunidad({super.key});

  @override
  State<MiembroComunidad> createState() => _MiembroComunidadState();
}

class _MiembroComunidadState extends State<MiembroComunidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Miembro Comunidad"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              _mostrarInfoApp(context);
            },
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.teal],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Servicios ofrecidos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _crearBoton(
                              context,
                              'Técnicas de administración comunitaria',
                              Icons.business,
                              null,
                            ),
                            const SizedBox(width: 15),
                            _crearBoton(
                              context,
                              'Administración de economía familiar',
                              Icons.monetization_on,
                              AdminEcoFamiliar(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: _crearBoton(
                            context,
                            'Gestión turística',
                            Icons.hotel,
                            null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context, String texto, IconData icono, Widget? paginaDestino) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // ignore: unnecessary_null_comparison
            if (paginaDestino != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => paginaDestino),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Funcionalidad en desarrollo')),
            );
          }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icono, color: Colors.teal, size: 35),
                const SizedBox(height: 5),
                Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarInfoApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Descripción de la Aplicación"),
          content: const Text(
              "Modelo de gestión de servicios que ayuda a los miembros de la comunidad a acceder a diversos servicios esenciales."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

class GestionTuristicaPage {
}

class EcoFamiliarPage {
}
