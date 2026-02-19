import 'package:flutter/material.dart';
import '../models/receta.dart';
import 'formulario_receta_screen.dart';
import '../services/receta_service.dart';


class DetalleRecetaScreen extends StatelessWidget {
   final Receta receta;
  final RecetaService _service = RecetaService();

  DetalleRecetaScreen({super.key, required this.receta});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(receta.nombre),
  actions: [
    IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormularioRecetaScreen(receta: receta),
          ),
        );
      },
    ),
    IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        await _service.eliminarReceta(receta.id);
        if (context.mounted) Navigator.pop(context);
      },
    ),
  ],
),

      body: StreamBuilder<Receta>(
  stream: _service.obtenerRecetaPorId(receta.id),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final recetaActualizada = snapshot.data!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            recetaActualizada.categoria,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          const Text(
            'Ingredientes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(recetaActualizada.ingredientes),

          const SizedBox(height: 20),

          const Text(
            'Pasos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(recetaActualizada.pasos),
        ],
      ),
    );
  },
),

    );
  }
}
