import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<String> obtenerNombre() async {
    print("Obteniendo nombre");
    await Future.delayed(Duration(seconds: 2));
    return "Jhonny";
  }

  Future<String> tarea1() async {
    await Future.delayed(Duration(seconds: 2));
    return "Tarea 1 completada";
  }

  Future<int> dividir(int a, int b) async {
    if (b == 0) {
      throw Exception("No se puede dividir entre cero");
    }
    await Future.delayed(Duration(seconds: 2));
    return a ~/ b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("Inicio");
          final nombre = await obtenerNombre();
          print("El nombre es $nombre");
          print("Fin");
        },
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final resultado = await dividir(10, 0);
                  print(resultado);
                } catch (e, stack) {
                  print("Error: $e");
                  print("Stack: $stack");
                }
              },
              child: Text("Manejo de errores"),
            ),

            ElevatedButton(
              onPressed: () async {
                print("Ejcutando tareas en paralelo......");

                final resultados = await Future.wait([
                  tarea1(),
                  obtenerNombre(),
                ]);

                print("---------------------------------------");
                print(resultados);
                print("---------------------------------------");
              },
              child: Text("Futures en paralelo"),
            ),
          ],
        ),
      ),
    );
  }
}
