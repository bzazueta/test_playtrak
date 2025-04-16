
import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/Environment.dart';
import '../models/User.dart';

class UserService{
  ///obtenemos la url que se encuentra enel archivo de configuración Environment
  final String _url = Environment.URL;
  ///inicalizamos dio ibrería o cliente que nos permite realizar peticiones http
  Dio dio = Dio();

  ///metodo que nos permite realizar la petición a una api o servidor externo y listar uan lista de usuarios
  ///la respuesta es de tipo User ya que conocemos el objeto o modelo de datos que nos esta regresando la api o el servidor
  /// usamos Future Sirve para trabajar con tareas asincrónicas que tardan un tiempo en completarse Consultar una API o base de datos etc.
  Future<User?> getPosts() async {
    ///usamos try catch para el manejo de excepciones y errores y evitar el crasheo de la aplicación
    try
    {
      ///inicalizamos dio que es la librería o cliente que nos permite realizar peticiones http
      var response = await dio.get('${_url}/getAllApiCrud.php');
      ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
      print('respuesta ${response}');
      ///convertimos la respuesta en json a un objeto de tipo User
      final User user = userFromJson(json.encode(response.data));
      ///retornamos la respuesta de tipo User
      return user;
    } catch (e) {
      ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
      print('error ${e}' );
      ///retornamos null cuando no se puede convertir a objeto
      return null;
    }
  }


}