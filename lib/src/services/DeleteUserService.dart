
import 'package:flutter/foundation.dart';

import '../api/Environment.dart';
import 'package:dio/dio.dart' as dio;

class DeleteUserService{
  final String _url = Environment.URL;

  Future<dynamic> deleteUser(idUser) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'id_user': idUser,
      });
      var response = await dio.Dio().post('$_url/deleteUser.php',data: formData);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('error $e' );
      }
      return e;
    }
  }
}