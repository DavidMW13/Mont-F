import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Verifica si el usuario está autenticado con Firebase Authentication.
  static Future<bool> isUserAuthenticated() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null; // Devuelve true si el usuario está autenticado
  }

  // Método para obtener el rol del usuario desde Firestore.
  static Future<String?> getUserRole(String userId) async {
    try {
      // Buscamos el documento en la colección 'admin' que corresponde al usuario.
      final docSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(userId)  // Usamos el UID del usuario en FirebaseAuth
          .get();

      if (docSnapshot.exists) {
        // Si el documento existe, devolvemos el rol del usuario
        return docSnapshot['role']; 
      } else {
        // Si no existe el documento, significa que no es un usuario registrado
        return null;
      }
    } catch (e) {
      print("Error al obtener el rol: $e");
      return null;
    }
  }

  
  

  // Método para iniciar sesión con nombre de usuario y contraseña.
  static Future<UserCredential?> signInWithEmailPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return null;
    }
  }

  // Método para cerrar sesión.
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

