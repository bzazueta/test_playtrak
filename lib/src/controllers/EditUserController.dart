import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:test_playtrack/src/services/AddUserService.dart';
import 'package:test_playtrack/src/services/EditUserService.dart';
import '../view/widgets/MySnackBar.dart' show MySnackbar;

class EditUserController{

  TextEditingController nameUserController =  TextEditingController();
  TextEditingController phoneUserController =  TextEditingController();
  BuildContext? context;
  final EditUserService _editUserService = EditUserService();
  late ImageProvider imageProvider;
  File? imageFile;
  PickedFile? pickedFile;

  void editUser(BuildContext context,idUser,String image_url) async{
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Editando usuario...');
    print('Entro en metodo editUser EditUserController');
     bool validate = true;
    if(nameUserController.text.trim().isEmpty){
      pd.close();
      validate = false;
      MySnackbar.show(context, 'DEBES INGRESAR UN USUARIO');
    }
    if(validate == true){
      if(phoneUserController.text.trim().isEmpty){
        pd.close();
        validate = false;
        MySnackbar.show(context, 'DEBES INGRESAR UNA CELULAR');
      }
    }

    if(validate == true){

      try
      {
        dynamic data = null;
        if(imageFile != null && imageFile != ""){
           data = await _editUserService.editUser(nameUserController.text.trim(),phoneUserController.text.trim(),idUser,imageFile,"");

        }else{
          data = await _editUserService.editUserPhotoServer(nameUserController.text.trim(),phoneUserController.text.trim(),idUser,imageFile,image_url);

        }
        final _data = json.decode(data.toString());
        if (_data['Respuesta'] == 'Ok') {
          pd.close();
          print('Metodo editUser success EditUserController');
          MySnackbar.show(context, 'USUARIO EDITADO');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'listUser');

          });
        }
        else {
          pd.close();
          MySnackbar.show(context, _data['Msg'] );
        }
      }catch(e)
      {
        pd.close();
        print('Error en metodo editUser ${e.toString()} EditUserController');
        MySnackbar.show(context, e.toString());
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
    await Permission.camera.request();
    await Permission.photos.request();
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);

    }
    Navigator.pop(context!);

  }

}