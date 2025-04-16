import 'package:flutter/material.dart';

///clase o vista que nos permite visualizar la pantalla home la cual contiene una opción
///para poder usar la funcionalidades de la app se uso StatelessWidget ya que esta vista
///no requiere de cambios de estados solo es visual y tiene un evento click para enviarte
///a la pantalla correspondiente

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {

    ///lista de opciones de funcionalidades para mostrar al usuario
    final options = [
      {
        'title': 'Examen Mobile Playtrak App Crud',
        'description1': 'Listado de usuarios',
        'description2': 'Agregar usuarios',
        'description3': 'Editar usuarios',
        'description4': 'Eliminar usuarios',
        'icon': Icons.person,
        'gradient': [Colors.blue, Colors.lightBlueAccent],
        'route': 'listUser'
      },

    ];

    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            ///recorremos la lista de opciones y le pasamos el index del  GridView.builder
            final option = options[index];
            ///usamos GestureDetector para captuar el evento cuando el usuario haga click en el elementode la lista de opciones que se muestran en la panttalla home
            return GestureDetector(
              onTap: () {
                ///nos envia a la pantalla correspondiente segun sea el valor de la ruta para este ejemplo solo se usa una ruta
                Navigator.pushNamed(context, '${option['route']}',arguments:{});
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: option['gradient'] as List<Color>,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      option['icon'] as IconData,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      option['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      option['description1'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      option['description2'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      option['description3'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      option['description4'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width:double.infinity,
                      child: Text(
                        'Da click para continuar',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


