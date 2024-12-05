import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelpageEstudio extends StatelessWidget {
  const ModelpageEstudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Modelado 3D',
        style: TextStyle(
          // Especifica la fuente Great Vibes
          color: Color.fromARGB(255, 224, 184, 122), // Color del texto
          fontSize: 30, // Ajusta el tamaño de la fuente
        ),
      )),
      body: const ModelViewer(
        backgroundColor: Color.fromARGB(255, 73, 71, 71),
        src: 'assets/3d/estudio.glb',
        alt: 'A 3D model of an astronaut',
        ar: true,
        autoRotate: true,
        iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        disableZoom: true,
      ),
    );
  }
}
