import 'package:dio/dio.dart' as dio;
import 'package:test_playtrack/src/api/Environment.dart';

class AddUserService{
  final String _url = Environment.URL;

  Future<dynamic> addUser(nameUser, phoneUser, fileImage) async {
    try {
      String? fileName ="";
      fileName = fileImage?.path.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        'name': nameUser,
        'phone': phoneUser,
        'image' : await dio.MultipartFile.fromFile(fileImage!.path, filename:fileName),

      });
      var response = await dio.Dio().post('${_url}/AddUser.php',data: formData);
      return response;
    } catch (e) {
      print('error ${e}' );
      return e;
    }
  }
}