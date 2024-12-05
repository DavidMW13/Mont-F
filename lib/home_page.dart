import 'package:flutter/material.dart';
import 'view/inicio_page.dart';
import 'view/sobre_nosotros_page.dart';
import 'view/registrar_cita_page.dart';
import 'view/iniciar_sesion_page.dart';
import 'view/packages_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Widget _currentPage = InicioPage();

  static final List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    //GalleryPage(),
    PackagesPage(),
    SobreNosotrosPage(),
    //Modelpage(),
    RegistrarCitaPage(),
    IniciarSesionPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _widgetOptions[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/Logo MontF.png', // Reemplaza con la ruta de tu logo
            height: 100, // Tamaño ajustado para hacerlo más grande
            width: 100, // Agregado para controlar la proporción
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Mont. F - Estudio De Fotografía',
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
          //BottomNavigationBarItem(
          //icon: Icon(Icons.photo_album), label: 'Galería'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_filter), label: 'Paquetes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info), label: 'Sobre Nosotros'),
          //BottomNavigationBarItem(
          //icon: Icon(Icons.mode_edit_outline), label: 'Modelo 3D'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Agendar Cita'),
          BottomNavigationBarItem(
              icon: Icon(Icons.login), label: 'Iniciar Sesión'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
