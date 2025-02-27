import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

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
                height:
                    MediaQuery.of(context).size.height * 0.5, // Altura reducida
                width: MediaQuery.of(context).size.width *
                    0.9, // Mantengo el mismo ancho
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de la descripción con color diferente
                        const Text(
                          'Descripción de la Aplicación',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A), // Gris oscuro
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Descripción
                        const Text(
                          'Modelo de gestión de servicios que ayuda a los miembros de la comunidad a acceder a diversos servicios esenciales, con un enfoque en la organización, economía, y desarrollo comunitario.',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Colors.teal, // Color teal para la descripción
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Título para los servicios con color diferente
                        const Text(
                          'Servicios ofrecidos',
                          style: TextStyle(
                            fontSize: 18, // Tamaño de texto ajustado
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A), // Gris oscuro
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Lista de viñetas con iconos
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.business, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Técnicas de administración comunitaria (Manejo de costos fijos).',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Icon(Icons.monetization_on, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Administración de economía familiar.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Icon(Icons.hotel, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Gestión turística.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
