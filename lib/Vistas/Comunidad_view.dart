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
                height:
                    MediaQuery.of(context).size.height * 0.5, // Altura ajustada
                width: MediaQuery.of(context).size.width *
                    0.9, // Mantengo el mismo ancho
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Título para los servicios
                        const Text(
                          'Servicios ofrecidos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A), // Gris oscuro
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Botones para los servicios con separación
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _crearBoton(
                                context,
                                'Técnicas de administración comunitaria',
                                Icons.business),
                            const SizedBox(
                                width: 15), // Espacio entre los botones
                            _crearBoton(
                                context,
                                'Administración de economía familiar',
                                Icons.monetization_on),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Botón "Gestión turística" en el centro
                        Center(
                          child: _crearBoton(
                              context, 'Gestión turística', Icons.hotel),
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

  // Método para crear los botones
  Widget _crearBoton(BuildContext context, String texto, IconData icono) {
    return Container(
      width: 120, // Tamaño fijo más pequeño para los botones
      height: 120, // Tamaño fijo más pequeño para los botones
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco
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
            // Acción de navegación o detalle
            // Aquí puedes agregar la lógica de cada servicio
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icono,
                    color: Colors.teal, size: 35), // Tamaño del ícono reducido
                const SizedBox(height: 5),
                Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black), // Tamaño de texto reducido
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para mostrar la descripción adicional al presionar el icono de información
  void _mostrarInfoApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Descripción de la Aplicación"),
          content: const Text(
              "Modelo de gestión de servicios que ayuda a los miembros de la comunidad a acceder a diversos servicios esenciales, con un enfoque en la organización, economía, y desarrollo comunitario."),
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

  // Método para el cierre de sesión
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