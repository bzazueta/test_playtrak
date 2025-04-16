import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:test_playtrack/src/services/AddUserService.dart';
import 'package:test_playtrack/src/services/EditUserService.dart';
import '../view/widgets/MySnackBar.dart' show MySnackbar;

///esta clase nos permite agregar un usuario a la base de datos

class EditUserController{

  ///TextEditingController capturamos lo que ingresa el usuario
  TextEditingController nameUserController =  TextEditingController();
  TextEditingController phoneUserController =  TextEditingController();
  ///decalaramos el contexto el cual va ser utilizado como parametro en los metodos
  BuildContext? context;
  ///inicializamos la clase EditUserService que contiene la petición a la api
  final EditUserService _editUserService = EditUserService();
  ///decalaramos la variable imageFile la cual contendran la imagen capturada por el usuario
  File? imageFile;
  ///variable que permite seleccionar la imagen ya sea de galería o de la camará
  PickedFile? pickedFile;

  Function? refresh;

  ///metodo que inicializa el controller y obtenemos el contexto desde la vista y la funcion refresh()
  Future init(BuildContext context,Function refresh) async {
    print('Entro en metodo init AddUserController');
    this.refresh = refresh;
    this.context = context;
  }

  ///metodo que nos permite editar un usuario a la bd. este metodo es asyncrona y recibe como parametros el contexto,
  ///idUser para saber que usuario se va editar,String image_url imagen que ya tiene guradada en el servidor
  ///es decir, que no bloquean la ejecución del resto de la app
  /// mientras esperan una respuesta (por ejemplo, de una API, una base de datos o un archivo).
  void editUser(BuildContext context,idUser,String image_url) async{
    ///inicializamos el progress dialog
    ProgressDialog pd = ProgressDialog(context: context);
    ///le damos una duración y agregamos eltexto que queremos mostrarle al usuario
    pd.show(max: 100, msg: 'Editando usuario...');
    ///mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
    print('Entro en metodo editUser EditUserController');
    ///inicializamos la varible validate en true para validar los campos vacios
     bool validate = true;
    ///valida que el nombre de usuario no este vacio con .isEmpty y quita los espacios en blanco con .trim() nameUserController.text.trim().isEmpty
    if(nameUserController.text.trim().isEmpty){
      ///cerramos el dialogo ya que al estar vacio detiene la operación de editar usuario
      pd.close();
      ///cambiamos el valor a false para que no pueda avanzar hasta editar el usuario
      validate = false;
      ///mostarmos un mensaje al usuario indicando que debe ingresar datos
      MySnackbar.show(context, 'DEBES INGRESAR UN USUARIO');
    }
    ///valida que el celular de usuario no este vacio con .isEmpty y quita los espacios en blanco con .trim() phoneUserController.text.trim().isEmpt
    if(validate == true){
      if(phoneUserController.text.trim().isEmpty){
        pd.close();
        validate = false;
        MySnackbar.show(context, 'DEBES INGRESAR UNA CELULAR');
      }
    }
    ///validamos si los campos no estan vacios para poder avanzar al siguiente bloque de código que agrega al usuario a bd
    if(validate == true){
      ///usamos try catch para el manejo de excepciones y errore y evitar el crasheo de la aplicación
      try
      {
        ///inicializamos la variable data tipo dynamyc ya es que es el tipo de dato que nos regresa el metodo _editUserService.editUser
        dynamic data = null;
        ///si el usuario capturo la imagen para agregar una nueva entra a esta condicón o flujo,.
        if(imageFile != null && imageFile != ""){
          ///enviamos al metodo nombre, celular e imagen nueva recién capturada
           data = await _editUserService.editUser(nameUserController.text.trim(),phoneUserController.text.trim(),idUser,imageFile,"");

        }else{
          ///enviamos al metodo nombre, celular e imagen ya capturada anteriormente
          data = await _editUserService.editUserPhotoServer(nameUserController.text.trim(),phoneUserController.text.trim(),idUser,imageFile,image_url);

        }
        ///decodificamos el json que viene en la repsuesta del servidor o api
        final _data = json.decode(data.toString());
        ///obtenemos los valores en un objeto de Dart (Map o List)
        if (_data['Respuesta'] == 'Ok') {
          ///cerramos el dialogo
          pd.close();
          ///mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
          print('Metodo editUser success EditUserController');
          ///mostarmos un mensaje al usuario indicando que el 'USUARIO EDITADO'
          MySnackbar.show(context, 'USUARIO EDITADO');
          ///agregamos un delay de tiempo de 3 segundos para nos envié a la pantalla list users
          Future.delayed(Duration(seconds: 3), () {
            ///cierra la pantalla actual
            Navigator.pop(context);
            ///nos abre la pantalla listuser
            Navigator.pushNamed(context, 'listUser');

          });
        }
        else {
          ///si no se puede decodificar la respuesta cerramos el dialogo
          pd.close();
          ///mostarmos un mensaje al usuario indicando el mensaje de error
          MySnackbar.show(context, _data['Msg'] );
        }
      }catch(e)
      {
        ///si hay una excepción o error cerramos el dialogo
        pd.close();
        ///mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
        print('Error en metodo editUser ${e.toString()} EditUserController');
        ///mostarmos un mensaje al usuario indicando el mensaje de error
        MySnackbar.show(context, e.toString());
      }
    }

  }

  ///muestar un modal con las opciones para capturar la imagen de galería o si desea tomar una fotografía con la camará
  void showAlertDialog(BuildContext context_) {
    ///obtenemos el contexto de la vista para mostrar el dialogo
    this.context = context_;
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          ///selecionamos de galería
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA')
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          ///selecionamos de camará
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

  ///metodo que nos permite obtener la imagen del dispositivo
  Future selectImage(ImageSource imageSource) async {
    ///se piden permisos necesarios para la captura de imagenes
    await Permission.camera.request();
    await Permission.photos.request();
    ///utilizamos ImagePicker libería para obtener la fotografía como un archivo
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      ///obtenemos la ruta del archivo
      imageFile = File(pickedFile!.path);

    }
    ///cerramos el dialog al terminar de seleccionar la imagen
    Navigator.pop(context!);
    refresh!();
  }

}