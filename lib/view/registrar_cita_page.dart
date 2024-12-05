import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class RegistrarCitaPage extends StatefulWidget {
  @override
  _RegistrarCitaPageState createState() => _RegistrarCitaPageState();
}

class _RegistrarCitaPageState extends State<RegistrarCitaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  String _selectedAsunto = 'Fotografía de Retrato';
  DateTime? _selectedDate;
  bool isLoggedIn = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      helpText: 'Selecciona una fecha disponible',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color.fromARGB(255, 224, 184, 122),
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[900],
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _registrarCitaEnFirebase() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('citas').add({
          'nombre': _nombreController.text,
          'apellido': _apellidoController.text,
          'correo': _correoController.text,
          'telefono': _telefonoController.text,
          'direccion': _direccionController.text,
          'asunto': _selectedAsunto,
          'fecha': _selectedDate?.toIso8601String(),
          'vista': false, // Agrega este campo
        });

        // Limpiar los campos después de registrar la cita
        _nombreController.clear();
        _apellidoController.clear();
        _correoController.clear();
        _telefonoController.clear();
        _direccionController.clear();
        setState(() {
          _selectedDate = null;
          _selectedAsunto =
              'Fotografía de Retrato'; // Restablecer a valor predeterminado
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cita registrada exitosamente')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar la cita: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agendar Cita',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre(s)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
                    return 'Solo se permiten letras';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidoController,
                decoration: InputDecoration(labelText: 'Apellido(s)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$').hasMatch(value)) {
                    return 'Solo se permiten letras';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _correoController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor ingrese un correo válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su número de teléfono';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Solo se permiten números';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Por favor ingrese un número de teléfono válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su dirección';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAsunto,
                decoration: InputDecoration(labelText: 'Asunto'),
                items: <String>[
                  'Fotografía de Retrato',
                  'Fotografía Personalizada',
                  'Fotografía de Eventos',
                  'Sesión Familiar',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAsunto = newValue!;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Fecha no seleccionada'
                          : 'Fecha seleccionada: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Spacer(),
                    Text(
                      '¡Solo puedes registrar una cita con una cuenta!',
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Seleccionar Fecha'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: isLoggedIn ? _registrarCitaEnFirebase : null,
                child: Text('Registrar Cita'),
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
    home: RegistrarCitaPage(),
    theme: ThemeData.dark(), // Cambia el tema según tu estilo preferido
  ));
}
