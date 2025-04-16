
import 'package:flutter/foundation.dart';

import '../api/Environment.dart';
import 'package:dio/dio.dart' as dio;

class DeleteUserService{
  ///obtenemos la url que se encuentra enel archivo de configuración Environment
  final String _url = Environment.URL;

  ///metodo que nos permite realizar la petición a una api o servidor externo y eliminar  la infomación del usuario
  ///la respuesta es de tipo dynamic para poder manejar la respuesta cuando no se puede mapear a un objeto o modelo de datos
  /// usamos Future Sirve para trabajar con tareas asincrónicas que tardan un tiempo en completarse Consultar una API o base de datos etc.
  Future<dynamic> deleteUser(idUser) async {
    ///usamos try catch para el manejo de excepciones y errores y evitar el crasheo de la aplicación
    try
    {
      ///creamos un formdata ya que el server espera la infomacion en formulario html
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
      });
      ///inicalizamos dio que es la librería o cliente que nos permite realizar peticiones http
      var response = await dio.Dio().post('$_url/deleteUser.php',data: formData);
      ///retornamos la respuesta
      return response;
    } catch (e) {
      if (kDebugMode) {
        ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
        print('error $e' );
      }
      ///retornamos el mensaje de error
      return e;
    }
  }
}