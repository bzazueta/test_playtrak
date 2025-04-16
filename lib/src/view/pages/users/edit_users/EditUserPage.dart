import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_playtrack/src/controllers/EditUserController.dart';

/**En esta pantalla podemos ver la UI para editar los datos del usuario la cual es
 *StatefulWidget ya que para la captura no se necesita un gestor de estados
 * ya que la vista o UI no cambia reactivamente(Getx RX). ya que la información que
 * se visualiza en la UI la pasamos por argumentos con Get.offNamed('/editUser',arguments:{})
 * para no realizar una petición al servidor**/

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {

  EditUserController _editUserController = EditUserController();
  String idUser = "";
  String image = "";

  @override
  Widget build(BuildContext context) {
    print('info entro EditUserPage');
    /// Recuperamos los argumentos con Get.arguments
    final args = Get.arguments as Map;
    _editUserController.nameUserController.text =  args['name'].toString() ?? '';
    _editUserController.phoneUserController.text = args['phone'].toString() ?? '';
    idUser =  args['idUser'].toString();
    image =  args['image'].toString();


    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                ///navegacion tradicional flutter para cerrar la pantalla como finish de android
                Navigator.pop(context);
              },
              child: Container(
                  margin: EdgeInsets.only(left:15,top:15),
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back_ios)
              ),
            ),
            SizedBox(height: heigth * 0.2,),
            _imageUser(context),
            SizedBox(height: heigth * 0.1,),
            Text('Editar Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),),
            _textFieldUserName(),
            _textFieldUserPhone(),
            _btnCreateUser(context,idUser)
          ],
        ),
      ),
    );
  }

  ///Widget donde cargamos la imagen del usuario si existe si no agreamos una por default AssetImage('assets/img/user_image.png'))
  ///si se captura la imagen también se muestra en este widget
  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: (){
         _editUserController.showAlertDialog(context);
      },//
      child: Container(
        color: Colors.white10,
        height: 75,
        child:  CircleAvatar(
          backgroundImage:  _editUserController.imageFile == null
              ? (image.isNotEmpty
              ? NetworkImage(image)
              : AssetImage('assets/img/user_image.png')) // Cambia la ruta de tu imagen por defecto
              : FileImage(_editUserController.imageFile!, ),
          radius: 40,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _textFieldUserName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
        controller: _editUserController.nameUserController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre Usuario',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.green[800]
            ),
            prefixIcon: Icon(
              Icons.person_sharp,
              color: Colors.green[800],
            )
        ),
      ),
    );
  }

  Widget _textFieldUserPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        style: TextStyle(color: Colors.green[800],fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
        controller: _editUserController.phoneUserController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Celular Usuario',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: Colors.green[800]
            ),
            prefixIcon: Icon(
              Icons.phone_iphone,
              color: Colors.green[800],
            )
        ),
      ),
    );
  }

  Widget _btnCreateUser(BuildContext context,idUser)
  {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 15),

      child: ElevatedButton(
          onPressed:(){
            ///llamamos al metod para editar los datos del usuario
            _editUserController.editUser(context,idUser,image);
          },
          style:  ElevatedButton.styleFrom(
              backgroundColor:  Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add_alt_1,
                  color: Colors.white
              ),

              SizedBox(width: 7 ),
              Text(
                'Editar Usuario',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'
                ),
              ),
            ],
          )

      ),
    );
  }
}
