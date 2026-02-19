class Receta {
  final String id;
  final String nombre;
  final String ingredientes;
  final String pasos;
  final String categoria;
  final String imagenUrl;

  Receta({
    required this.id,
    required this.nombre,
    required this.ingredientes,
    required this.pasos,
    required this.categoria,
    required this.imagenUrl,
  });

  factory Receta.fromFirestore(Map<String, dynamic> data, String id) {
    return Receta(
      id: id,
      nombre: data['nombre'] ?? '',
      ingredientes: data['ingredientes'] ?? '',
      pasos: data['pasos'] ?? '',
      categoria: data['categoria'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
    );
  }
}
