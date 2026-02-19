import 'package:flutter/material.dart';
import '../services/receta_service.dart';
import '../models/receta.dart';
import 'formulario_receta_screen.dart';
import 'detalle_receta_screen.dart';



class ListaRecetasScreen extends StatelessWidget {
  ListaRecetasScreen({super.key});

  final RecetaService _service = RecetaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recetario Inteligente')),
      body: StreamBuilder<List<Receta>>(
        stream: _service.obtenerRecetas(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final recetas = snapshot.data!;

          if (recetas.isEmpty) {
            return const Center(child: Text('No hay recetas aún'));
          }

          return ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              return ListTile(
  title: Text(receta.nombre),
  subtitle: Text(receta.categoria),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalleRecetaScreen(receta: receta),
      ),
    );
  },
);

            },
          );
        },
      ),
    floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FormularioRecetaScreen(),
      ),
    );
  },
  child: const Icon(Icons.add),
),

    );
  }
}
