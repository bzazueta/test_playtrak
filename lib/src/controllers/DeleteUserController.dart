
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_playtrack/src/services/DeleteUserService.dart';
import 'package:test_playtrack/src/services/UserService.dart';

import '../models/User.dart';
import '../view/widgets/MySnackBar.dart';

class DeleteUserController extends GetxController{
  
  DeleteUserService _deleteUserService = DeleteUserService();
  UserService _userService = UserService();
  final isLoading = false.obs;
  final filteredItems = <ApiCrud>[].obs;
  final items = <ApiCrud>[].obs;
  final searchText = ''.obs;
  
  void deleteUser(idUser,BuildContext context) async{
    print('entro a post');

    try {
      isLoading.value = true;
      var data = await _deleteUserService.deleteUser(idUser);
      if (data['Respuesta'] == 'Ok') {
        //_progressDialog?.close();
        MySnackbar.show(context, 'USUARIO ELIMINADO');
        Future.delayed(Duration(seconds: 3), () {
             getPosts();
        });
      }
      else {
        // _progressDialog?.close();
        MySnackbar.show(context, data['Msg'] );
      }
    } catch (e) {
      e.toString();
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      isLoading.value = false;
    }
  }

  void getPosts() async{
    print('entro a post');

    try {
      isLoading.value = true;
      var data = await _userService.getPosts();
      items.value = data!.apiCrud;
      filteredItems.value = items.value;
    } catch (e) {
      e.toString();
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      isLoading.value = false;
    }
  }
  
}