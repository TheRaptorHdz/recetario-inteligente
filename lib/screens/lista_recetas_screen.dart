import 'package:flutter/material.dart';
import '../services/receta_service.dart';
import '../models/receta.dart';
import 'formulario_receta_screen.dart';
import 'detalle_receta_screen.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ListaRecetasScreen extends StatelessWidget {
  ListaRecetasScreen({super.key});

  final RecetaService _service = RecetaService();

  @override
Widget build(BuildContext context) {
  final AuthService _auth = AuthService();
  final user = FirebaseAuth.instance.currentUser;

  return Scaffold(
    appBar: AppBar(
      title: const Text('Recetario Inteligente'),
      actions: [
        if (user != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                user.email ?? '',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await _auth.logout();
          },
        ),
      ],
    ),

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
