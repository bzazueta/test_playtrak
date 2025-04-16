import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test_playtrack/src/controllers/AddUserController.dart';

/**En esta pantalla podemos ver la UI captura de usuario la cual es
 *StatefulWidget ya que para la captura no se necesita un gestor de estados
 * ya que la vista o UI no cambia reactivamente(Getx RX) **/

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AdduserPageState();
}

class _AdduserPageState extends State<AddUserPage> {

  /// inicializamos el controller es el que contiene todos los metodos
  /// necesarios para la captura de usuario*
  AddUserController _addUserController = AddUserController();

  /// primer método que se ejecuta al cargar la pagina o vista
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ///ejecutar código justo después que los widgets han sido renderizado completamente en pantalla
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _addUserController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///usamos MediaQuery.of(context).size.width para usar los porcentajes de pantalla lo que nos ayuda hacer el diseño responsivo
    ///para cualquier pantalla del dispositivo
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                ///solo agrego para mostrar navegación tradicional flutter ya que aqui no usamos Getx
                ///como gestor de estados
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
            Text('Crear Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),),
            _textFieldUserName(),
            _textFieldUserPhone(),
            _btnCreateUser(context)
          ],
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return GestureDetector(
      onTap: (){
         ///metodo para seleccionar la imagen del usuario
        _addUserController.showAlertDialog(context);
      },
      child: Container(
        color: Colors.white10,
        height: 75,
        child: CircleAvatar(
          backgroundImage: _addUserController.imageFile != null
              ? FileImage(_addUserController.imageFile!)
              : AssetImage('assets/img/user_image.png') as ImageProvider,
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
        controller: _addUserController.nameUserController, ///capturamos la información ingresada por el usuario
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
        controller: _addUserController.phoneUserController,
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

  Widget _btnCreateUser(BuildContext context)
  {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 15),

      child: ElevatedButton(
        onPressed:(){
           ///llamamos al método que guarda la información del usuario
            _addUserController.addUser(context);
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
                'Crear Usuario',
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

  /// Aquí actualizas variables que afectan la UI para este caso se actualiza la imagen al
  /// capturar la imagen
  void refresh() {
    setState(() {});
  }

}
