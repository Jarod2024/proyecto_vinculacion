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
        title: Text("Líder comunidad"),
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
          'Bienvenido, Líder de la comunidad',
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
