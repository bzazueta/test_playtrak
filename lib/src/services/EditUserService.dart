import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:test_playtrack/src/api/Environment.dart';

class EditUserService{
  ///obtenemos la url que se encuentra enel archivo de configuración Environment
  final String _url = Environment.URL;

  ///metodo que nos permite realizar la petición a una api o servidor externo y guardar la infomación del usuario cuando selecciona una nueva fotografía
  ///la respuesta es de tipo dynamic para poder manejar la respuesta cuando no se puede mapear a un objeto o modelo de datos
  /// usamos Future Sirve para trabajar con tareas asincrónicas que tardan un tiempo en completarse Consultar una API o base de datos etc.
  Future<dynamic> editUser(nameUser, phoneUser,idUser,fileImage,imageUrl) async {
    ///usamos try catch para el manejo de excepciones y errore y evitar el crasheo de la aplicación
    try {
      ///inicalizamos la variable que contendra el nombre del archivo imagen
      String? fileName ="";
      ///obtenemos el nombre
      fileName = fileImage?.path.split('/').last;
      ///creamos un formdata ya que el server espera la infomacion en formulario html
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
        'name': nameUser,
        'phone': phoneUser,
        'image' :  await dio.MultipartFile.fromFile(fileImage!.path, filename:fileName),
        'imagen_url' : ""
      });
      ///inicalizamos dio que es la librería o cliente que nos permite realizar peticiones http
      var response = await dio.Dio().post('$_url/editUser.php',data: formData);
      ///retornamos la respuesta
      return response;
    } catch (e) {
      if (kDebugMode) {
        ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
        print('error $e' );
      }
      ///retornamos la respuesta de error
      return e;
    }
  }

  Future<dynamic> editUserPhotoServer(nameUser, phoneUser,idUser,fileImage,imageUrl) async {
    try {
      String? fileName ="";
      fileName = fileImage?.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
        'name': nameUser,
        'phone': phoneUser,
        'image' :  "",
        'imagen_url' : imageUrl
      });
      var response = await dio.Dio().post('$_url/editUser.php',data: formData);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('error $e' );
      }
      return e;
    }
  }
}