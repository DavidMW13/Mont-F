import 'package:flutter/material.dart';
import '../modelo_camara.dart';
import '../modelo_estudio.dart';

class SobreNosotrosPage extends StatelessWidget {
  const SobreNosotrosPage({super.key});

  // Función que se ejecuta al presionar el botón
  void ejecutarScript() {
    // Aquí se puede integrar la lógica del script que tienes
  }

  @override
  Widget build(BuildContext context) {
    // Lista de imágenes para el portafolio
    final List<String> imagePaths = [
      'assets/images/04.jpg',
      'assets/images/20230928101414_IMG_4547.jpg',
      'assets/images/PicsArt_09-19-08.51.36.jpg',
      'assets/images/PicsArt_09-19-08.54.37.jpg',
      'assets/images/20240217183451_IMG_5565.jpg',
      'assets/images/20240623114514_IMG_6725.jpg',
      //'assets/images/20231118152107_IMG_5210.jpg',
      'assets/images/portafolio/img 03.jpg',
      'assets/images/portafolio/img 08.jpg',
      'assets/images/portafolio/pexels-hasmukh-abchung-413074376-16897442.jpg',
      //'assets/images/portafolio/pexels-george-chambers-413080139-19817004.jpg',
      'assets/images/portafolio/pexels-caspersomia-27060156.jpg',
      'assets/images/portafolio/pexels-murillohm-10649109.jpg',
      'assets/images/portafolio/pexels-brett-sayles-14353625.jpg',
      'assets/images/portafolio/pexels-uraw-17615698.jpg',
    ];

    // Obtener el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sobre Nosotros',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mont F - Estudio de Fotografía',
              style: TextStyle(
                fontFamily: 'GreatVibes',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 224, 184, 122),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'En Mont F Estudio, nos dedicamos a capturar los momentos más importantes de tu vida.',
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              'Nuestro objetivo es hacer que cada sesión sea única y memorable.',
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            // Primer Card
            Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Imagen a la izquierda
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        '/images/monse/Foto.jpg', // Reemplaza con tu imagen
                        width: screenWidth * 0.3, // Ajuste dinámico del tamaño
                        height: screenWidth * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Texto a la derecha
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '¿Quién soy?',
                            style: TextStyle(
                              fontFamily: 'GreatVibes',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 184, 122),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Soy Licenciada en Artes Visuales, titulada por la Universidad Autónoma de Tlaxcala.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'La fotografía es una herramienta poderosa para transmitir mensajes a través de los recuerdos capturados.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Segundo Card con botón
            Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Imagen a la izquierda
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/sobren/estudio.png', // Reemplaza con tu imagen
                        width: screenWidth * 0.3, // Ajuste dinámico del tamaño
                        height: screenWidth * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Texto a la derecha
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nuestro Estudio',
                            style: TextStyle(
                              fontFamily: 'GreatVibes',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 184, 122),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Conoce más sobre nuestro espacio de trabajo y nuestras instalaciones.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Contamos con un sistema de iluminación de estudio que incluye flashes estroboscópicos, softboxes, y reflectores, permitiéndonos crear la atmósfera perfecta para cada toma.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Para ver el estudio en modelado 3D, da clic en el siguiente botón.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModelpageEstudio()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 224, 184, 122),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Ver Estudio',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.grey[850],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Imagen a la izquierda
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        '/images/sobren/camara.png', // Reemplaza con tu imagen
                        width: screenWidth * 0.3, // Ajuste dinámico del tamaño
                        height: screenWidth * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Texto a la derecha
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nuestro Equipo (Cámara)',
                            style: TextStyle(
                              fontFamily: 'GreatVibes',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 224, 184, 122),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Descubre el equipo de cámaras con el que trabajamos.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Contamos con la cámara Canon EOS Rebel T7 que nos permite ofrecer resultados profesionales a nuestros clientes.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Para ver la cámara en modelado 3D, da clic en el siguiente botón',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ModelpageCamara()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 224, 184, 122),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Ver Equipo',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Portafolio de imágenes
            const Text(
              'Portafolio',
              style: TextStyle(
                fontFamily: 'GreatVibes',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 224, 184, 122),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Tres columnas
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SobreNosotrosPage(),
    theme: ThemeData.dark(),
  ));
}
