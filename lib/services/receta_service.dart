import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/receta.dart';

class RecetaService {
  final CollectionReference recetasRef =
      FirebaseFirestore.instance.collection('recetas');

  Stream<List<Receta>> obtenerRecetas() {
    return recetasRef.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Receta.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    });
  }
  Future<void> agregarReceta({
  required String nombre,
  required String ingredientes,
  required String pasos,
  required String categoria,
  required String imagenUrl,
}) async {
  await recetasRef.add({
    'nombre': nombre,
    'ingredientes': ingredientes,
    'pasos': pasos,
    'categoria': categoria,
    'imagenUrl': imagenUrl,
    'fechaCreacion': FieldValue.serverTimestamp(),
  });
}
Future<void> eliminarReceta(String id) async {
  await recetasRef.doc(id).delete();
}
Future<void> actualizarReceta({
  required String id,
  required String nombre,
  required String ingredientes,
  required String pasos,
  required String categoria,
}) async {
  await recetasRef.doc(id).update({
    'nombre': nombre,
    'ingredientes': ingredientes,
    'pasos': pasos,
    'categoria': categoria,
  });
}
Stream<Receta> obtenerRecetaPorId(String id) {
  return recetasRef.doc(id).snapshots().map(
        (doc) => Receta.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        ),
      );
}


}
