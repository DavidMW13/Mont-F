// import 'package:flutter/material.dart';
// import 'package:prueba_integradora/auth_service.dart'; // Asegúrate de importar el servicio de autenticación

// class HomeUsuario extends StatelessWidget {
//   const HomeUsuario({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Panel Usuario'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () async {
//               await AuthService.signOut(); // Cerrar sesión
//               // Redirigir al inicio de sesión y reiniciar el estado
//               Navigator.pushNamed(
//                 context,
//                 '/', // Elimina todas las rutas previas
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(child: const Text('Bienvenido Usuario')),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'usua/inicio_page_usua.dart';
import 'usua/sobre_nosotros_usua.dart';
import 'usua/registrar_cita_usua.dart';
import 'usua/packages_page_usua.dart';
import 'package:prueba_integradora/home_page.dart';

class HomeUsuario extends StatefulWidget {
  const HomeUsuario({super.key});
  
  

  @override
  _HomeUsuarioState createState() => _HomeUsuarioState();
}

class _HomeUsuarioState extends State<HomeUsuario> {
  
  int _selectedIndex = 0;
  Widget _currentPage = InicioPage();

  static final List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    PackagesPage(),
    SobreNosotrosPage(),
    RegistrarCitaPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 4) { // Índice del botón "Cerrar Sesión"
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
        _currentPage = _widgetOptions[index];
      });
    }
  }

  void _logout() {
    // Aquí puedes realizar las acciones necesarias para cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()), // Redirige a la pantalla de inicio de sesión
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.asset(
            'assets/images/Logo MontF.png', // Reemplaza con la ruta de tu logo
            height: 100, // Tamaño ajustado para hacerlo más grande
            width: 100, // Agregado para controlar la proporción
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Mont. F - Estudio De Fotografía ¡Bienvenid@ Usuario!',
          style: TextStyle(
            fontFamily: 'GreatVibes', // Especifica la fuente Great Vibes
            color: Color.fromARGB(255, 224, 184, 122), // Color del texto
            fontSize: 30, // Ajusta el tamaño de la fuente
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_filter), label: 'Paquetes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info), label: 'Sobre Nosotros'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Agendar Cita'),
          BottomNavigationBarItem(
              icon: Icon(Icons.login), label: 'Cerrar Sesión'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
