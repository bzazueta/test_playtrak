import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_playtrack/src/services/UserService.dart';

import '../models/User.dart';
import '../services/DeleteUserService.dart';
import '../view/widgets/MySnackBar.dart';



///esta clase nos permite obtener la lista de usuarios y eliminar usuarios extiende de GetxController
///para manejar los estados de manera reactiva
class UserController extends GetxController{

  ///inicializamos la clase UserService que contiene la petición a la api
  UserService _userService = UserService();
  ///inicializamos la clase DeleteUserService que contiene la petición a la api para eliminar
  DeleteUserService _deleteUserService = DeleteUserService();
  ///declaramos una variable de tipo List<ApiCrud>[] observable para la actualización reactiva con GetX y nos sirve para filtrar la busqueda
  final filteredItems = <ApiCrud>[].obs;
  ///variable que se muestra un circulo de progreso al invocar el metodo getUser
  final isLoading = false.obs;
  ///variable donde cargamos la lista de usuarios
  final items = <ApiCrud>[].obs;

 ///metodo que se ejecuta al iniciar el controller
  @override
  void onInit() {
    ///ejecutamos el metodo getUsers()
    getUsers();
    super.onInit();
  }

  ///metodo asincrono que nos permite listar todos los usuarios registrados
  void getUsers() async{
    ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
    print('entro a getUsers');
    ///usamos try catch para el manejo de excepciones y errores y evitar el crasheo de la aplicación
    try
    {
      ///muestra un circulo de carga en la vista mientras se termina la petición
      isLoading.value = true;
      ///obtenemos la respuesta del servidor
      var data = await _userService.getPosts();
      ///pasamos la lista de usuario a la variable items
      items.value = data!.apiCrud;
      ///pasamos la variable items a filteresItems ya que es la lista final que se mostrara al usuario
      filteredItems.value = items.value;
    } catch (e) {
      ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
      print('Error en metodo getUsers ${e.toString()}');
      ///mostramos un mensaje de error al usuario  Get.snackbar snackbar de Getx
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      ///cerramos el circulo de carga en la vista una vez que termino la petición
      isLoading.value = false;
    }
  }

  ///metodo que sirve para filtrar la busqueda
  void filterItems(String query) {
    ///valida si el parametro esta vacio
    if (query.isEmpty) {
      ///pasa toda la lista filteredItems.value =
      filteredItems.value = items;
    } else {
      ///pasa solo el suario encontrado en la lista
      filteredItems.value = items
          .where((item) =>
          item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  ///metodo asincrono que permite eliminar un usuario
  void deleteUser(idUser,BuildContext context) async{
    ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
    print('entro a metodo deleteUser');

    try {
      ///muestra un circulo de carga en la vista mientras se termina la petición
      isLoading.value = true;
      ///obtenemos la respuesta del servidor
      var data = await _deleteUserService.deleteUser(idUser);
      ///decodificamos el json que viene en la repsuesta del servidor o api
      final _data = json.decode(data.toString());
      ///obtenemos los valores en un objeto de Dart (Map o List)
      if (_data['Respuesta'] == 'Ok') {
          ///llamamos a getUsers para que nos cargue la lista actualizada de manera reactiva con Getx
          getUsers();
      }
      else {
        ///mostarmos un mensaje al usuario indicando el mensaje de error
        MySnackbar.show(context, _data['Msg'] );
      }
    } catch (e) {
      ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
      print('Error en metodo deleteUser ${e.toString()}');
      ///mostramos mensaje de error
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      ///cerramos el dialogo una vez terminada la petición
      isLoading.value = false;
    }
  }

}