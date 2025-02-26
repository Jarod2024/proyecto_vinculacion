import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class LiderComunidad extends StatefulWidget {
  const LiderComunidad({super.key});

  @override
  State<LiderComunidad> createState() => _LiderComunidadState();
}

class _LiderComunidadState extends State<LiderComunidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Líder comunidad"),
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
                height: MediaQuery.of(context).size.height *
                    0.6, // Carta más pequeña
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de la descripción con color negro
                        const Text(
                          'Descripción de la Aplicación',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Color negro
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Descripción con el mismo tamaño de texto
                        const Text(
                          'Modelo de gestión de servicios que ayuda a los líderes comunitarios a identificar las necesidades de los miembros de las comunidades, promoviendo un enfoque integral para fortalecer la organización y la gestión comunitaria.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal, // Color teal
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Título para los servicios con color negro
                        const Text(
                          'Servicios ofrecidos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Color negro
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
                                Icon(Icons.account_balance, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Técnicas tributarias.',
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
                                Icon(Icons.group_work, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Técnicas Administración de liderazgo comunitario.',
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
                                Icon(Icons.gavel, color: Colors.teal),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Asesoramiento en derecho laboral y tributario.',
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Esto elimina el banner de depuración
    home: LiderComunidad(),
  ));
}
