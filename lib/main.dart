import 'package:flutter/material.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sesión 13 - Lista de Tareas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const ListaTareas(),
    );
  }
}

/// Modelo de datos oficial (Sección 7 / Diapositiva 12)
class Tarea {
  String titulo;
  bool completada;

  Tarea({
    required this.titulo,
    this.completada = false,
  });
}

/// Widget con estado para la pantalla principal (Sección 8 / Diapositivas 18-22)
class ListaTareas extends StatefulWidget {
  const ListaTareas({super.key});

  @override
  State<ListaTareas> createState() => _ListaTareasState();
}

class _ListaTareasState extends State<ListaTareas> {
  // Variables de estado declaradas según la guía oficial
  final List<Tarea> _tareas = [];
  final TextEditingController _controlador = TextEditingController();

  // Paso 2: Agregar tarea envolviendo la modificación en setState()
  void _agregarTarea() {
    final texto = _controlador.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _tareas.add(Tarea(titulo: texto));
    });
    _controlador.clear();
  }

  // Paso 4: Alternar estado completado de la tarea
  void _alternarCompletada(int indice) {
    setState(() {
      _tareas[indice].completada = !_tareas[indice].completada;
    });
  }

  // Paso 5: Eliminar tarea por su índice
  void _eliminarTarea(int indice) {
    setState(() {
      _tareas.removeAt(indice);
    });
  }

  // Liberación del controlador de texto en el ciclo de vida
  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int total = _tareas.length;
    final int completadas = _tareas.where((t) => t.completada).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tareas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de progreso calculado dinámicamente
            if (total > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Progreso actual',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$completadas de $total completadas',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircularProgressIndicator(
                      value: total == 0 ? 0 : completadas / total,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

            if (total > 0) const SizedBox(height: 16),

            // Formulario de ingreso de nuevas tareas
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controlador,
                        decoration: const InputDecoration(
                          hintText: 'Nueva tarea...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.add_task),
                        ),
                        onSubmitted: (_) => _agregarTarea(),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: _agregarTarea,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Visualización de la lista
            Expanded(
              child: _tareas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 72,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Sin tareas todavía',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _tareas.length,
                      itemBuilder: (context, indice) {
                        final tarea = _tareas[indice];
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: ListTile(
                            onTap: () => _alternarCompletada(indice),
                            leading: Checkbox(
                              value: tarea.completada,
                              onChanged: (_) => _alternarCompletada(indice),
                            ),
                            title: Text(
                              tarea.titulo,
                              style: TextStyle(
                                decoration: tarea.completada
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tarea.completada
                                    ? Colors.grey
                                    : Colors.black87,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => _eliminarTarea(indice),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}