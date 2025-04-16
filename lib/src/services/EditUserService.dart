import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:test_playtrack/src/api/Environment.dart';

class EditUserService{
  final String _url = Environment.URL;

  Future<dynamic> editUser(nameUser, phoneUser,idUser,fileImage,imageUrl) async {
    try {
      String? fileName ="";
      fileName = fileImage?.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
        'name': nameUser,
        'phone': phoneUser,
        'image' :  await dio.MultipartFile.fromFile(fileImage!.path, filename:fileName),
        'imagen_url' : ""
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