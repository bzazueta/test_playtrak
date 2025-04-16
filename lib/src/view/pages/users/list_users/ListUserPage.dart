import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:test_playtrack/src/controllers/UserController.dart';

/**En esta pantalla podemos ver la UI lista de usuarios la cual es
 *StatelessWidget ya que vamos a necesitar un gestor de estados
 * para la actulización de datos en pantalla de manera reactiva
 * ya que la vista o UI va a cmbiar reactivamente(Getx RX) cuando
 * se cargue la lista con información o se elimine un usuario **/
class ListUserPage extends StatelessWidget {
  ListUserPage({super.key});

  ///inicializamos Get  y cargamos el controller Get.put(UserController())
  final  userController = Get.put(UserController());
  ///metodo que se ejecuta al inicializar o cargar la vista
  Future<void> _fetchAndLoadData() async {
    ///llamamos al metodo en el controller y obtenemos la lista de usuarios
    userController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    ///si hay una excepción mostramos en consola que entro al metodo para depurar eventos de acuerdo con la lógica que se está ejecutando.
    print('info entro ListUserPage');
    ///ejecutamos el metodo
    _fetchAndLoadData();
    return Scaffold(
       backgroundColor: Colors.white,
       body: Column(
         children: [
           GestureDetector(
             onTap: (){
               ///cerramos pantalla al dar click en icono regresar
               Navigator.pop(context);
             },
             child: Container(
               margin: EdgeInsets.only(left:15,top:15),
               alignment: Alignment.centerLeft,
                 child: Icon(Icons.arrow_back_ios)
             ),
           ),
           ///widget que sirve para filtrar la busqueda de usuarios
           Padding(
             padding: const EdgeInsets.only(left:16,right: 16,top:45),
             child: TextField(
               onChanged: userController.filterItems,
               decoration: InputDecoration(
                 labelText: 'Buscar',
                 prefixIcon: const Icon(Icons.search),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),
             ),
           ),
           SizedBox(height: 15,),
           Obx(() {
             ///si el estado isloading es true muestra el CircularProgressIndicator()
             if (userController.isLoading.value) {
               return const Center(child: CircularProgressIndicator());
             }
             ///si la lista no contiene datos muestra el texto No hay resultados
             if (userController.filteredItems.isEmpty) {
               return const Center(child: Text('No hay resultados'));
             }
            ///si la lista contiene datos carga la información de los usuarios
             return Expanded(
               child: Container(
                 margin: const EdgeInsets.only(bottom: 15),
                 color: Colors.grey[100],
                 child: ListView.builder(
                   padding: const EdgeInsets.all(10.0),
                   itemCount:  userController.filteredItems.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Card(
                       color: Colors.white,
                       shadowColor: Colors.grey[100],
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Row(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(30),
                                   child:   Image.network(
                                     userController.filteredItems[index].image,
                                     width: 60,
                                     height: 60,
                                     fit: BoxFit.cover,
                                     errorBuilder: (context, error, stackTrace) {
                                       return Image.asset(
                                         'assets/img/user_image.png',
                                         width: 60,
                                         height: 60,
                                         fit: BoxFit.cover,
                                       );
                                     }
                                   )
                                 ),
                                 Expanded(
                                   child:
                                   Container(
                                     margin: const EdgeInsets.only(left: 15),
                                     child:Text( userController.filteredItems[index].name.toString(),
                                       style: const TextStyle(
                                           fontSize: 16.0,
                                           color: Colors.black,
                                           fontFamily: 'Montserrat'
                                       ),
                                     ),
                                   ),
                                 ),
                                 Text( userController.filteredItems[index].phone.toString(),
                                   style: const TextStyle(
                                       fontSize: 12.0,
                                       color: Colors.blueAccent,
                                       fontFamily: 'Montserrat'
                                   ),
                                 ),
                               ],
                             ),

                              SizedBox(
                               height: 15.0,
                               child: Center(
                                 child: Container(
                                   margin: EdgeInsetsDirectional.only(top:5,start: 1.0, end: 1.0),
                                   height: 1.0,
                                   color: Colors.black12,
                                 ),
                               ),
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                   onTap: (){
                                     ///nos envia a la pantalla addUser
                                     Get.offNamed('/addUser');
                                   },
                                   child: Row(
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: const Text('Agregar',
                                           style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: 'Montserrat'
                                           ),
                                         ),
                                       ),
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: Icon(Icons.person_add_alt_1,
                                           color:  userController.filteredItems[index].name.toString() =='' ? Colors.green[700] : Colors.red,
                                         ),
                                       )
                                     ],
                                   ),

                                 ),
                                 GestureDetector(
                                   onTap: (){
                                     ///nos envia a la pantalla editUser y pasamos los datos del usuario por argumentos para no realizar una petición mas al servidor
                                     Get.offNamed('/editUser',arguments:{"name": userController.filteredItems[index].name.trim(),"phone":userController.filteredItems[index].phone.trim(),"idUser":userController.filteredItems[index].id,"image":userController.filteredItems[index].image});
                                   },
                                   child: Row(
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: const Text('Editar',
                                           style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: 'Montserrat'
                                           ),
                                         ),
                                       ),
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: Icon(Icons.edit,
                                           color:  userController.filteredItems[index].name.toString() =='' ? Colors.green[700] : Colors.red,
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                                 GestureDetector(
                                   onTap: (){
                                     ///llamamos al metodo que elimina el usuario en userController.deleteUser
                                     userController.deleteUser( userController.filteredItems[index].id, context);
                                   },
                                   child: Row(
                                     children: [
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: const Text('Eliminar',
                                           style: TextStyle(
                                               fontSize: 12.0,
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold,
                                               fontFamily: 'Montserrat'
                                           ),
                                         ),
                                       ),
                                       Container(
                                         margin: const EdgeInsets.only(top:10,left: 5,right: 5),
                                         child: Icon(Icons.delete,
                                           color:  userController.filteredItems[index].name.toString() =='' ? Colors.green[700] : Colors.red,
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                 ),
               ),
             );


           }),
         ],
       ),
    );

  }
}
