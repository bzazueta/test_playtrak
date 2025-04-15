
import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/Environment.dart';
import '../models/User.dart';

class UserService{

  final String _url = Environment.URL;
  Dio dio = Dio();

  Future<User?> getPosts() async {
    try {
      print('${_url}getAllApi.php');
      var response = await dio.get('${_url}/getAllApiCrud.php');
      print('respuesta ${response}');
      final User user = userFromJson(json.encode(response.data));
      return user;
    } catch (e) {
      print('error ${e}' );
      return null;
    }
  }


}