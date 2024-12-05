import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Package {
  final String? imagePath; // Modificado para permitir imágenes opcionales.
  final String name;
  final String description;
  final double price;

  Package({
    this.imagePath,
    required this.name,
    required this.description,
    required this.price,
  });

  // Método para convertir datos de Firestore a un objeto Package
  factory Package.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Package(
      imagePath: data['imagePath'] as String?,
      name: data['nombre'] as String,
      description: data['descripcion'] as String,
      price: double.tryParse(data['precio'].toString()) ?? 0.0,
    );
  }
}

class PackagesPage extends StatelessWidget {
  // Método para obtener los paquetes desde Firestore
  Stream<List<Package>> _getPackages() {
    return FirebaseFirestore.instance.collection('packages').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Package.fromFirestore(doc)).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paquetes Fotográficos',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[850],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Package>>(
          stream: _getPackages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error al cargar los paquetes'));
            }

            final packages = snapshot.data ?? [];

            if (packages.isEmpty) {
              return Center(child: Text('No hay paquetes disponibles'));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Tres tarjetas por fila
                crossAxisSpacing: 8.0, // Espaciado horizontal entre tarjetas
                mainAxisSpacing: 8.0, // Espaciado vertical entre tarjetas
                childAspectRatio:
                    0.7, // Ajusta la proporción para controlar la altura de las tarjetas
              ),
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: package.imagePath != null
                            ? Image.network(
                                package.imagePath!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                            : Container(
                                color: Colors.grey,
                                child: Center(
                                  child: Text(
                                    'Sin Imagen',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          package.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 224, 184, 122),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          package.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          maxLines: 2, // Limita la descripción a 2 líneas
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$${package.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PackagesPage(),
    theme: ThemeData.dark(),
  ));
}
