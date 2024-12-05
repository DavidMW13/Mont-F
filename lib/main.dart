import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'auth_service.dart';
import 'package:prueba_integradora/view/home_admin.dart';  // Página de home_admin
import 'package:prueba_integradora/view/home_usuario.dart';  // Página de home_usuario
import 'package:prueba_integradora/view/iniciar_sesion_page.dart'; // Página de inicio de sesión

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class PhotographyStudioColors {
  static const Color background = Color(0xFF1C1C1E); // Gris oscuro neutro
  static const Color accent = Color(0xFFE0B87A); // Dorado suave
  static const Color primaryText = Color(0xFFFFFFFF); // Blanco
  static const Color secondaryText = Color(0xFFB3B3B3); // Gris claro
  static const Color highlight = Color(0xFF529A86); // Verde esmeralda
  static const Color error = Color(0xFFE57373); // Rojo suave
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ESTUDIO DE FOTOGRAFÍA',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: PhotographyStudioColors.accent,
        scaffoldBackgroundColor: const Color(0xFFECEFF1),
        cardColor: const Color(0xFFF3F7F0),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          bodyMedium: TextStyle(color: const Color.fromARGB(255, 250, 250, 250)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: PhotographyStudioColors.background,
          selectedItemColor: PhotographyStudioColors.accent,
          unselectedItemColor: PhotographyStudioColors.secondaryText,
        ),
        colorScheme: ColorScheme.dark(
          primary: PhotographyStudioColors.accent,
          secondary: PhotographyStudioColors.highlight,
          error: PhotographyStudioColors.error,
          surface: PhotographyStudioColors.background,
          onSurface: const Color.fromARGB(255, 140, 140, 140),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/home_usuario': (context) => HomeUsuario(),
        '/home_admin': (context) => HomeAdmin(),
      },
      onGenerateRoute: (settings) {
  if (settings.name == '/home_admin') {
    // Verificar si el usuario está autenticado y tiene rol de 'admin'
    return MaterialPageRoute(
      builder: (context) {
        return FutureBuilder<bool>(
          future: AuthService.isUserAuthenticated(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (!snapshot.hasData || !snapshot.data!) {
              // Si no está autenticado, redirigir al login
              return IniciarSesionPage();
            }

            // Obtener el UID del usuario autenticado
            final String userId = FirebaseAuth.instance.currentUser!.uid;

            // Obtener el rol del usuario desde Firestore
            return FutureBuilder<String?>(
              future: AuthService.getUserRole(userId),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                }

                if (roleSnapshot.hasError || !roleSnapshot.hasData) {
                  // Si no se puede obtener el rol, redirigir al login o mostrar un error
                  return IniciarSesionPage();
                }

                // Comprobar el rol y redirigir a la página correspondiente
                if (roleSnapshot.data == 'admin') {
                  return HomeAdmin(); // Si es administrador, mostrar la página de admin
                } else {
                  return HomeUsuario(); // Si es usuario, mostrar la página de usuario
                }
              },
            );
          },
        );
      },
    );
  }
  return null; // Si la ruta no es '/home_admin', la ruta por defecto
},


    );
  }
}
