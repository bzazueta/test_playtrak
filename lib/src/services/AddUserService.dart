import 'package:dio/dio.dart' as dio;
import 'package:test_playtrack/src/api/Environment.dart';

class AddUserService{
  final String _url = Environment.URL;

  Future<dynamic> addUser(nameUser, phoneUser) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'name': nameUser,
        'phone': phoneUser,
        'image' : "https://firebasestorage.googleapis.com/v0/b/pagosproumm.appspot.com/o/images%2F1729188993020.jpg?alt=media&token=f5346b95-d8b1-4b94-8058-0ee3ad84fc35"
      });
      var response = await dio.Dio().post('${_url}/AddUser.php',data: formData);
      return response;
    } catch (e) {
      print('error ${e}' );
      return e;
    }
  }
}