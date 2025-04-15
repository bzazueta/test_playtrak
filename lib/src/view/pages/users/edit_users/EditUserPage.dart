import 'package:flutter/material.dart';
import 'package:test_playtrack/src/controllers/EditUserController.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {

  EditUserController _editUserController = EditUserController();
  String idUser = "";
  @override
  Widget build(BuildContext context) {
    print('info entro EditUserPage');
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    _editUserController.nameUserController.text =  arg['name'].toString() ?? '';
    _editUserController.phoneUserController.text = arg['phone'].toString() ?? '';
    idUser =  arg['idUser'].toString();

    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: heigth * 0.2,),
            Text('Editar Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),),
            _textFieldUserName(),
            _textFieldUserPhone(),
            _btnCreateUser(context,idUser)
          ],
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
            _editUserController.editUser(context,idUser);
          },
          style:  ElevatedButton.styleFrom(
              backgroundColor:  Colors.green[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),// _con.isEnable ? _con.createAsunto : (){print('pressed');},//devolon _con.register,// //delivery con.registerDelivery
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
