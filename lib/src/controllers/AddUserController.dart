import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_playtrack/src/services/AddUserService.dart';
import '../view/widgets/MySnackBar.dart' show MySnackbar;

class AddUserController{

  TextEditingController nameUserController = new TextEditingController();
  TextEditingController phoneUserController = new TextEditingController();
  BuildContext? context;
  AddUserService _addUserService = AddUserService();
  File? imageFile;
  PickedFile? pickedFile;
  Function? refresh;

  Future init(BuildContext context,Function refresh) async {
    print('Entro en metodo init AddUserController');
    this.refresh = refresh;
    this.context = context;
  }

  void addUser(BuildContext context) async{
    print('Entro en metodo addUser AddUserController');
     bool validate = true;
    if(nameUserController.text.trim().isEmpty){
      validate = false;
      MySnackbar.show(context!, 'DEBES INGRESAR UN USUARIO');
    }
    if(validate == true){
      if(phoneUserController.text.trim().isEmpty){
        validate = false;
        MySnackbar.show(context!, 'DEBES INGRESAR UNA CELULAR');
      }
    }

    if(validate == true){

      try
      {
        var data = await _addUserService.addUser(nameUserController.text.trim(),phoneUserController.text.trim());
        final _data = json.decode(data.toString());
        if (_data['Respuesta'] == 'Ok') {
          print('Metodo addUser success AddUserController');
          MySnackbar.show(context, 'USUARIO AGREGADO');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'listUser');

          });
        }
        else {
         // _progressDialog?.close();
          MySnackbar.show(context!, _data['Msg'] );
        }
      }catch(e)
      {
       // _progressDialog?.close();
        print('Error en metodo addUser  AddUserController');
        MySnackbar.show(context!, e.toString());
      }
    }

  }

  void showAlertDialog(BuildContext context_) {
    this.context = context_;
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);

    }
    //Navigator.pop(context!);
    refresh!();
  }

  void finish()async{

    Navigator.pop(context!);
  }

}