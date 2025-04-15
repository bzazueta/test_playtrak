import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test_playtrack/src/controllers/AddUserController.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AdduserPageState();
}

class _AdduserPageState extends State<AddUserPage> {

  AddUserController _addUserController = AddUserController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _addUserController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
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
        _addUserController.showAlertDialog(context);
      },//_con.showAlertDialog,
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
        controller: _addUserController.nameUserController,
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

  void refresh() {
    setState(() {}); // CTRL + S
  }

}
