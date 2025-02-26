import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_vinculacion/BaseSqlLite.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _communityController = TextEditingController();
  String _role = 'Comunidad';
  bool _isObscure = true;
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _firestore.collection('usuarios').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'address': _addressController.text.trim(),
        'id': _idController.text.trim(),
        'phone': _phoneController.text.trim(),
        'community': _communityController.text.trim(),
        'role': _role,
        'uid': userCredential.user!.uid,
      });
      Map<String, dynamic> user = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'address': _addressController.text.trim(),
      'id_number': _idController.text.trim(),
      'phone': _phoneController.text.trim(),
      'community': _communityController.text.trim(),
      'role': _role,
      'uid': userCredential.user!.uid,
    };
    await DatabaseHelper().insertUser(user);


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.contains('@') ? null : 'Correo inválido',
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                  ),
                  validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                ),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'Cédula'),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  controller: _communityController,
                  decoration: const InputDecoration(labelText: 'Comunidad'),
                ),
                DropdownButtonFormField<String>(
                  value: _role,
                  items: ['Líder', 'Comunidad'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Rol'),
                  onChanged: (String? newValue) {
                    setState(() => _role = newValue!);
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _register,
                        child: const Text('Registrarse'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
