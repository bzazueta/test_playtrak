import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:test_playtrack/src/api/Environment.dart';

class EditUserService{
  final String _url = Environment.URL;

  Future<dynamic> editUser(nameUser, phoneUser,idUser) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
        'name': nameUser,
        'phone': phoneUser,
        'image' : "https://firebasestorage.googleapis.com/v0/b/pagosproumm.appspot.com/o/images%2F1729188993020.jpg?alt=media&token=f5346b95-d8b1-4b94-8058-0ee3ad84fc35"
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