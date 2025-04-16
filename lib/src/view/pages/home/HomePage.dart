import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {

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
      // {
      //   'title': 'Agregar Usuarios',
      //   'description': 'Agregar Usuarios',
      //   'icon': Icons.person_add_alt_1,
      //   'gradient': [Colors.purple, Colors.deepPurpleAccent],
      //   'route': 'listPost2'
      // },
      // {
      //   'title': 'Editar Usuarios',
      //   'description': 'Editar Usuarios',
      //   'icon': Icons.edit,
      //   'gradient': [Colors.orange, Colors.deepOrange],
      //   'route': 'listPost2'
      // },
      // {
      //   'title': 'Eliminar Usuarios',
      //   'description': 'Eliminar Usuarios',
      //   'icon': Icons.delete,
      //   'gradient': [Colors.red, Colors.redAccent],
      //   'route': 'listPost2'
      // },
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
            final option = options[index];
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Seleccionado:  ${option['route']}')),
                );
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


