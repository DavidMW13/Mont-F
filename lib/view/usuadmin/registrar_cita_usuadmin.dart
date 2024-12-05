import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Para el formato de la fecha

class AdminCitasPage extends StatelessWidget {
  // Función para eliminar una cita
  void _eliminarCita(BuildContext context, String citaId) {
    // Muestra el diálogo de confirmación antes de eliminar
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Cita'),
          content: Text('¿Estás seguro de que deseas eliminar esta cita?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo sin eliminar
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Elimina la cita si el usuario confirma
                FirebaseFirestore.instance
                    .collection('citas')
                    .doc(citaId)
                    .delete()
                    .then((value) {
                  Navigator.of(context).pop(); // Cierra el diálogo
                }).catchError((error) {
                  // Maneja errores si ocurre alguno al eliminar
                  print("Error al eliminar la cita: $error");
                  Navigator.of(context).pop(); // Cierra el diálogo
                });
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Citas Registradas',
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 224, 184, 122),
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('citas').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final citas = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Nombre',
                    style: TextStyle(color: Color.fromARGB(255, 224, 184, 122)),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Apellido',
                    style: TextStyle(color: Color.fromARGB(255, 224, 184, 122)),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Número',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Correo',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Asunto',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Fecha',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Estado',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Eliminar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 224, 184, 122),
                    ),
                  ),
                ),
              ],
              rows: citas.map((cita) {
                final data = cita.data() as Map<String, dynamic>;

                String formattedDate = 'Sin fecha';
                var fecha = data['fecha'];

                if (fecha != null) {
                  if (fecha is Timestamp) {
                    formattedDate =
                        DateFormat('yyyy-MM-dd').format(fecha.toDate());
                  } else if (fecha is String) {
                    formattedDate = fecha;
                  }
                }

                return DataRow(
                  cells: [
                    DataCell(Text("${data['nombre'] ?? 'Sin nombre'}",
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(data['apellido'] ?? 'Sin apellido',
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(data['telefono'] ?? 'Sin telefono',
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(data['correo'] ?? 'Sin correo',
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(data['asunto'] ?? 'Sin asunto',
                        style: TextStyle(color: Colors.black))),
                    DataCell(Text(formattedDate,
                        style: TextStyle(color: Colors.black))),
                    DataCell(Row(
                      children: [
                        Text(data['vista'] == true ? 'Vista' : 'No vista',
                            style: TextStyle(color: Colors.black)),
                        IconButton(
                          icon: Icon(
                            data['vista'] == true
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('citas')
                                .doc(cita.id)
                                .update({'vista': !(data['vista'] ?? false)});
                          },
                        ),
                      ],
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _eliminarCita(context,
                            cita.id); // Muestra el diálogo para eliminar
                      },
                    )),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
