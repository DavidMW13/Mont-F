import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarPaquetePage extends StatefulWidget {
  @override
  _EditarPaquetePageState createState() => _EditarPaquetePageState();
}

class _EditarPaquetePageState extends State<EditarPaquetePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPaqueteId;
  String? _nombrePaquete;
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  // Método para obtener los paquetes desde Firestore
  Stream<List<Map<String, dynamic>>> _getPaquetes() {
    return FirebaseFirestore.instance.collection('packages').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
              .toList(),
        );
  }

  // Método para cargar los datos del paquete seleccionado
  Future<void> _loadPaqueteData(String paqueteId) async {
    final paqueteSnapshot =
        await FirebaseFirestore.instance.collection('packages').doc(paqueteId).get();

    if (paqueteSnapshot.exists) {
      final data = paqueteSnapshot.data()!;
      setState(() {
        _nombrePaquete = data['nombre'];
        _precioController.text = data['precio'];
        _descripcionController.text = data['descripcion'];
      });
    }
  }

  // Método para actualizar el paquete en Firestore
  Future<void> _updatePaquete() async {
    if (_formKey.currentState!.validate() && _selectedPaqueteId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('packages')
            .doc(_selectedPaqueteId)
            .update({
          'precio': _precioController.text,
          'descripcion': _descripcionController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paquete actualizado exitosamente')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el paquete: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Paquete',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown para seleccionar paquete
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: _getPaquetes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error al cargar paquetes');
                  }

                  final paquetes = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    value: _selectedPaqueteId,
                    decoration: InputDecoration(labelText: 'Seleccionar paquete'),
                    items: paquetes.map((paquete) {
                      return DropdownMenuItem<String>(
                        value: paquete['id'],
                        child: Text(paquete['nombre']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPaqueteId = value;
                        _loadPaqueteData(value!);
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Por favor seleccione un paquete' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Campo para editar el precio
              TextFormField(
                controller: _precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio';
                  }
                  if (!RegExp(r'^[0-9]+(\.[0-9]{1,2})?$').hasMatch(value)) {
                    return 'Ingrese un precio válido (ej. 100.00)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo para editar la descripción
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Botón para actualizar el paquete
              ElevatedButton(
                onPressed: _updatePaquete,
                child: Text('Actualizar Paquete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditarPaquetePage(),
    theme: ThemeData.dark(),
  ));
}
