import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_playtrack/src/services/AddUserService.dart';
import 'package:test_playtrack/src/services/EditUserService.dart';
import '../view/widgets/MySnackBar.dart' show MySnackbar;

class EditUserController{

  TextEditingController nameUserController =  TextEditingController();
  TextEditingController phoneUserController =  TextEditingController();
  BuildContext? context;
  final EditUserService _editUserService = EditUserService();


  void editUser(BuildContext context,idUser) async{
    print('Entro en metodo editUser EditUserController');
     bool validate = true;
    if(nameUserController.text.trim().isEmpty){
      validate = false;
      MySnackbar.show(context, 'DEBES INGRESAR UN USUARIO');
    }
    if(validate == true){
      if(phoneUserController.text.trim().isEmpty){
        validate = false;
        MySnackbar.show(context, 'DEBES INGRESAR UNA CELULAR');
      }
    }

    if(validate == true){

      try
      {
        var data = await _editUserService.editUser(nameUserController.text.trim(),phoneUserController.text.trim(),idUser);
        final _data = json.decode(data.toString());
        if (_data['Respuesta'] == 'Ok') {
          //_progressDialog?.close();
          print('Metodo editUser success EditUserController');
          MySnackbar.show(context, 'USUARIO EDITADO');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'listUser');

          });
        }
        else {
         // _progressDialog?.close();
          MySnackbar.show(context, _data['Msg'] );
        }
      }catch(e)
      {
       // _progressDialog?.close();
        print('Error en metodo editUser ${e.toString()} EditUserController');
        MySnackbar.show(context, e.toString());
      }
    }

  }

}