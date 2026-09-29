# 📱 Sesión 13: setState y Manejo de Eventos (onPressed, onTap)

Repositorio oficial para la **Sesión 13** de la asignatura **Desarrollo de Software II (SIS048)** - Universidad Andina del Cusco.

---

## 📌 Síntesis Teórica

En esta sesión se aborda la interactividad en Flutter conectando eventos de usuario con actualizaciones en la interfaz gráfica:

1. **`setState()`:** Notifica al framework que las variables internas de un objeto `State` han cambiado, solicitando la ejecución de `build()` para reconstruir los widgets afectados.
2. **Callbacks de Eventos (`onPressed` / `onTap`):**
   - **`onPressed`:** Callback nativo en widgets de botones (`ElevatedButton`, `IconButton`). Asignar `null` deshabilita visual y funcionalmente el botón[cite: 1, 2].
   - **`onTap`:** Propiedad expuesta por `GestureDetector`, `InkWell` y `ListTile` para detectar pulsaciones simples[cite: 1, 2].
3. **Optimización con `ListView.builder`:** Renderizado eficiente y perezoso (lazy loading) para colecciones dinámicas[cite: 1, 2].
4. **Ciclo de Vida:** Liberación explícita del `TextEditingController` en el método `dispose()` para prevenir fugas de memoria[cite: 1, 2].

---

## 📊 Diagrama de Flujo de Eventos (ASCII)

```text
  [ Interacción del Usuario ]
               │
               ▼
   [ Callback: onTap / onPressed ]
               │
               ▼
   [ Ejecución de setState() ]  <-- Modifica _tareas (add / removeAt / toggle)
               │
               ▼
   [ Reconstrucción: build() ]  <-- Flutter compara el árbol de widgets
               │
               ▼
   [ Actualización de Pantalla ] <-- Refleja el cambio visualmente