import 'package:flutter/material.dart';
import '../services/receta_service.dart';
import '../models/receta.dart';


class FormularioRecetaScreen extends StatefulWidget {
  final Receta? receta;

  const FormularioRecetaScreen({super.key, this.receta});

  @override
  State<FormularioRecetaScreen> createState() =>
      _FormularioRecetaScreenState();
}


class _FormularioRecetaScreenState extends State<FormularioRecetaScreen> {
  @override
void initState() {
  super.initState();

  if (widget.receta != null) {
    _nombreController.text = widget.receta!.nombre;
    _ingredientesController.text = widget.receta!.ingredientes;
    _pasosController.text = widget.receta!.pasos;
    _categoriaController.text = widget.receta!.categoria;
  }
}

  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _ingredientesController = TextEditingController();
  final _pasosController = TextEditingController();
  final _categoriaController = TextEditingController();

  final RecetaService _service = RecetaService();

  bool _guardando = false;

  Future<void> _guardarReceta() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _guardando = true);

  if (widget.receta == null) {
    // CREAR
    await _service.agregarReceta(
      nombre: _nombreController.text.trim(),
      ingredientes: _ingredientesController.text.trim(),
      pasos: _pasosController.text.trim(),
      categoria: _categoriaController.text.trim(),
      imagenUrl: '',
    );
  } else {
    // EDITAR
    await _service.actualizarReceta(
      id: widget.receta!.id,
      nombre: _nombreController.text.trim(),
      ingredientes: _ingredientesController.text.trim(),
      pasos: _pasosController.text.trim(),
      categoria: _categoriaController.text.trim(),
    );
  }

  if (mounted) Navigator.pop(context);
}



  @override
  void dispose() {
    _nombreController.dispose();
    _ingredientesController.dispose();
    _pasosController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva receta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingresa un nombre' : null,
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingresa una categoría' : null,
              ),
              TextFormField(
                controller: _ingredientesController,
                decoration: const InputDecoration(labelText: 'Ingredientes'),
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingresa ingredientes' : null,
              ),
              TextFormField(
                controller: _pasosController,
                decoration: const InputDecoration(labelText: 'Pasos'),
                maxLines: 4,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Ingresa los pasos' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardando ? null : _guardarReceta,
                child: _guardando
                    ? const CircularProgressIndicator()
                    : const Text('Guardar receta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
