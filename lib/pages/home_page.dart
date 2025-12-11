import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<List<String>> getProducts() async {
    await Future.delayed(Duration(seconds: 3));
    return ["Manzana", "Zapatillas", "Zapatos", "Durazno"];
  }

  List<String> _products = [];

  Future<void> fetchProductos() async {
    _products = await getProducts();
    setState(() {});
    // getProducts().then((value) {
    //   _products = value;
    //   setState(() {});
    // });
  }

  @override
  void initState() {
    super.initState();
    // fetchProductos();
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
      body: FutureBuilder(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          print("Estado: ${snapshot.connectionState}");
          print("Has Error: ${snapshot.hasError}");
          print("Error: ${snapshot.error}");
          print("Has data: ${snapshot.hasData}");
          print("Data: ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            List<String> productsBuilder = snapshot.data;
            return Column(
              children: productsBuilder
                  .map((prod) => Card(child: ListTile(title: Text(prod))))
                  .toList(),
            );
          }

          // return Card(child: ListTile(title: Text("Hola")));
        },
      ),
      // body: _products.isEmpty
      //     ? Center(child: CircularProgressIndicator())
      //     : Center(
      //         child: Column(
      //           children: _products
      //               .map((e) => Card(child: ListTile(title: Text(e))))
      //               .toList(),
      //         ),
      //       ),

      //EJEMPLOS CON AWAIT Y LOS FUTURES
      // body: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () async {
      //           try {
      //             final resultado = await dividir(10, 0);
      //             print(resultado);
      //           } catch (e, stack) {
      //             print("Error: $e");
      //             print("Stack: $stack");
      //           }
      //         },
      //         child: Text("Manejo de errores"),
      //       ),

      //       ElevatedButton(
      //         onPressed: () async {
      //           print("Ejcutando tareas en paralelo......");

      //           final resultados = await Future.wait([
      //             tarea1(),
      //             obtenerNombre(),
      //           ]);

      //           print("---------------------------------------");
      //           print(resultados);
      //           print("---------------------------------------");
      //         },
      //         child: Text("Futures en paralelo"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
