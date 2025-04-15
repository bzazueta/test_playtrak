import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_playtrack/src/services/UserService.dart';

import '../models/User.dart';
import '../services/DeleteUserService.dart';
import '../view/widgets/MySnackBar.dart';

class UserController extends GetxController{

  UserService _userService = UserService();
  DeleteUserService _deleteUserService = DeleteUserService();
  final filteredItems = <ApiCrud>[].obs;
  final isLoading = false.obs;
  final items = <ApiCrud>[].obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async{
    print('entro a getUsers');

    try {
      isLoading.value = true;
      var data = await _userService.getPosts();
      items.value = data!.apiCrud;
      filteredItems.value = items.value;
    } catch (e) {
      print('Error en metodo getUsers ${e.toString()}');
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      isLoading.value = false;
    }
  }

  void filterItems(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredItems.value = items;
    } else {
      filteredItems.value = items
          .where((item) =>
          item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void deleteUser(idUser,BuildContext context) async{
    print('entro a metodo deleteUser');

    try {
      isLoading.value = true;
      var data = await _deleteUserService.deleteUser(idUser);
      final _data = json.decode(data.toString());
      if (_data['Respuesta'] == 'Ok') {
          getUsers();
      }
      else {
        // _progressDialog?.close();
        MySnackbar.show(context, _data['Msg'] );
      }
    } catch (e) {
      print('Error en metodo deleteUser ${e.toString()}');
      Get.snackbar('Error', 'No se pudo cargar la lista');
    } finally {
      isLoading.value = false;
    }
  }

}