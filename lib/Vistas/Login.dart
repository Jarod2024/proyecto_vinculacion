import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_vinculacion/BaseSqlLite.dart';
import 'package:proyecto_vinculacion/Vistas/Registro_Usuario.dart';
import 'Lideres_view.dart';
import 'Comunidad_view.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _signIn() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true;
    });

    // Verificar en SQLite
    bool isUserInSQLite = await _checkUserInSQLite();
    if (isUserInSQLite) {
      // Si el usuario está en SQLite, intentar el login con Firebase
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        route();
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Error al iniciar sesión')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El usuario no existe en la base de datos local')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
}

Future<bool> _checkUserInSQLite() async {
  // Verificar si el usuario existe en SQLite
  final db = await DatabaseHelper().database;
  final List<Map<String, dynamic>> result = await db.query(
    'users',
    where: 'email = ?',
    whereArgs: [_emailController.text.trim()],
  );

  return result.isNotEmpty; // Si la lista no está vacía, el usuario existe
  }


  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('role') == "Lider comunidad") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LiderComunidad()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MiembroComunidad()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('El usuario no existe en la base de datos')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Ingrese su correo o email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.email, color: Colors.teal),
                    ),
                    validator: (value) => value!.isEmpty ? 'Ingrese su email' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Ingrese su contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.teal,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    validator: (value) => value!.isEmpty ? 'Ingrese su contraseña' : null,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                      '¿No tienes cuenta? Regístrate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
