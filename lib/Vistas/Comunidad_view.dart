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
        title: Text("Miembro comunidad"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          'Bienvenido, Miembro de la comunidad',
          style: TextStyle(fontSize: 20),
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
