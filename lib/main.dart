import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:test_playtrack/src/view/pages/home/HomePage.dart';
import 'package:test_playtrack/src/view/pages/users/edit_users/EditUserPage.dart';
import 'src/view/pages/users/add_user/AddUserPage.dart';
import 'src/view/pages/users/list_users/ListUserPage.dart';




/**clase main es la clase principal donde se declara El GetMaterialApp para indicar a la aplicacion que
 * GetX manejara las rutas
 * themas de la aplicación colores**/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: 'home', /*** aqui en esta parte se declara la ruta inicial al abrir la aplicación **/
      // routes: {/*** aqui en esta parte se declara el resto de las rutas de la aplicación **/
      // 'home': (BuildContext context) => Homepage(),
      // 'listUser': (BuildContext context) => ListUserPage(),
      // 'addUser': (BuildContext context) => AddUserPage(),
      // 'editUser': (BuildContext context) => EditUserPage(),
      // },
      /** aqui en esta parte se declara el resto de las rutas de la aplicación usamos el gestor
       * de estados GetX
       * Navegación más limpia y simple * Pasar argumentos de forma sencilla
       * Transición entre pantallas fácil y flexible **/
      getPages: [
        GetPage(name: '/home', page: () => const Homepage()),
        GetPage(name: '/listUser', page: () =>  ListUserPage()),
        GetPage(name: '/addUser', page: () => const AddUserPage()),
        GetPage(name: '/editUser', page: () =>  EditUserPage()),
      ],
    //home: const Homepage(),
    );
  }
}


