import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  final bool isLoggedIn = false;

  // Función para abrir URL de redes sociales
  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir $url')),
      );
    }
  }

  // Función para guardar comentario en Firestore
  Future<void> _saveComment(BuildContext context, String comment,
      TextEditingController controller) async {
    if (comment.isEmpty) return; // Validar comentario vacío
    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'comment': comment,
        'timestamp': FieldValue.serverTimestamp(),
      });
      controller.clear(); // Limpiar campo de texto después de guardar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Comentario enviado correctamente!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      debugPrint("Error al guardar el comentario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hubo un error al enviar el comentario.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controlador del TextField para el comentario
    final TextEditingController commentController = TextEditingController();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Carrusel de imágenes en la parte superior
          CarouselSlider(
            options: CarouselOptions(
              height: 600,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOut,
            ),
            items: [
              'assets/images/carrucel/pexels-caspersomia-27060169.jpg',
              'assets/images/carrucel/pexels-eduardo-barrientos-140939364-27815948.jpg',
              'assets/images/carrucel/pexels-matvalina-12169557.jpg',
              'assets/images/carrucel/woman-6671171_1280.jpg',
              'assets/images/carrucel/pexels-norman-milwood-236004651-28182351.jpg',
              'assets/images/carrucel/20240922144938_IMG_8064.jpg'
            ].map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // Card con información
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      leading: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Color.fromARGB(255, 224, 184, 122),
                      ),
                      title: Text(
                        'Mont F - Estudio de Fotografía',
                        style: TextStyle(
                          fontFamily: 'GreatVibes',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 224, 184, 122),
                          fontSize: 30,
                        ),
                      ),
                      subtitle: Text(
                        'Capturando tus mejores momentos con profesionalismo y pasión.',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Nuestro estudio ofrece sesiones fotográficas únicas y personalizadas para capturar esos momentos especiales. ¡Reserva una cita hoy mismo!',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Determinar si es una pantalla pequeña
                bool isSmallScreen = constraints.maxWidth < 600;

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isSmallScreen
                        ? Column(
                            // Distribución en columna para pantallas pequeñas
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/foto.png',
                                  width: double.infinity, // Ocupa todo el ancho
                                  height:
                                      200, // Ajusta el alto para pantallas pequeñas
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Nuestros Servicios',
                                style: TextStyle(
                                  fontFamily: 'GreatVibes',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 224, 184, 122),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'En Mont F, nuestra pasión es la fotografía y la producción audiovisual. Nos dedicamos a ofrecer una amplia gama de servicios fotográficos y audiovisuales para satisfacer las necesidades de nuestros clientes, con el objetivo de brindar resultados excepcionales a través de la calidad de nuestro trabajo. Si deseas contar con fotografías y videos que destaquen por su calidad y estilo, Mont F es la elección perfecta. No dudes en contactarnos para conocer más sobre nuestros servicios.',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )
                        : Row(
                            // Distribución en fila para pantallas grandes
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/foto.png',
                                  width:
                                      350, // Tamaño fijo para pantallas grandes
                                  height: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Nuestros Servicios',
                                      style: TextStyle(
                                        fontFamily: 'GreatVibes',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 224, 184, 122),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'En Mont F, nuestra pasión es la fotografía y la producción audiovisual. Nos dedicamos a ofrecer una amplia gama de servicios fotográficos y audiovisuales para satisfacer las necesidades de nuestros clientes, con el objetivo de brindar resultados excepcionales a través de la calidad de nuestro trabajo. Si deseas contar con fotografías y videos que destaquen por su calidad y estilo, Mont F es la elección perfecta. No dudes en contactarnos para conocer más sobre nuestros servicios.',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),

          // Sección de Servicios Audiovisuales
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección del texto y la imagen decorativa a la derecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/inicio/img 06.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Image.asset(
                        'assets/images/inicio/pexels-alexander-mass-748453803-26795041.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Image.asset(
                        'assets/images/inicio/pexels-hannia-torres-348555462-14160806.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sección de comentarios y redes sociales al final de la página
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección de comentarios
                const SizedBox(width: 16),
                // Sección de redes sociales
                // Sección de comentarios
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '¡Solo puedes comentar con una cuenta!',
                        style: TextStyle(
                            fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Escribe un comentario...',
                          filled: true,
                          fillColor: const Color.fromARGB(255, 249, 249, 249),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: isLoggedIn
                              ? () {
                                  final comment = commentController.text.trim();
                                  _saveComment(
                                      context, comment, commentController);
                                }
                              : null, // Desactivado si no está logeado
                          child: const Text('Enviar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 90, 90, 90),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Sección de redes sociales
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Síguenos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        icon: const FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Color.fromARGB(255, 224, 184, 122),
                        ),
                        iconSize: 40,
                        onPressed: () {
                          _launchURL(context,
                              'https://www.instagram.com/fc.photos_mont/');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Sección de copyright
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '© Mont F Studio y J.J.C.T Studio',
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
