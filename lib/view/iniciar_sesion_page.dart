import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IniciarSesionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _iniciarSesion(BuildContext context) async {
    try {
      String usuario = _usuarioController.text.trim();
      String password = _passwordController.text.trim();

      // Verificar si el usuario existe en Firestore
      final querySnapshot = await _firestore
          .collection('admin')
          .where('usua', isEqualTo: usuario)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;

        // Verificar la contraseña
        if (doc['pass'] == password) {
          final role = doc['role'];

          if (role == 'admin') {
            print('Redirigiendo a la página de admin...');
            Navigator.pushNamed(context, '/home_admin');
          } else {
            print('Redirigiendo a la página de usuario...');
            // Aquí se obtiene el currentUser y se pasa a la pantalla de usuario
            User? currentUser = FirebaseAuth.instance.currentUser;
            Navigator.pushNamed(
              context,
              '/home_usuario',
              arguments: currentUser, // Pasar el currentUser como argumento
            );
          }

          // Limpiar los campos después de iniciar sesión
          _usuarioController.clear();
          _passwordController.clear();
        } else {
          _mostrarError(context, 'Contraseña incorrecta');
        }
      } else {
        _mostrarError(context, 'Usuario no encontrado');
      }
    } catch (e) {
      _mostrarError(context, 'Error al iniciar sesión: $e');
    }
  }

  Future<void> _registrarUsuario(BuildContext context) async {
    try {
      String usuario = _usuarioController.text.trim();
      String password = _passwordController.text.trim();

      // Registrar en Firestore con rol "usuario"
      await _firestore.collection('admin').add({
        'usua': usuario,
        'pass': password,
        'role': 'usuario',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso. Puedes iniciar sesión.')),
      );
    } catch (e) {
      _mostrarError(context, 'Error al registrar usuario: $e');
    }
  }

  void _mostrarError(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje, style: TextStyle(color: Colors.red))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iniciar Sesión',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 98, 98, 98),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: const Color.fromARGB(255, 55, 53, 53),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.redAccent,
                        size: 40,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Sugerencia: Si quieres registrarte, ingresa tus datos y despues click en el botón de Registrarse. Una vez registrado podras dar click al botón de Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _usuarioController,
                      decoration: const InputDecoration(labelText: 'Usuario'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su usuario';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _iniciarSesion(context);
                            }
                          },
                          child: const Text('Iniciar Sesión'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registrarUsuario(context);
                            }
                          },
                          child: const Text('Registrarse'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
