/******************************************************************************/
/**                      Javier Sapia 21/07/2019                             **/
/**                Ultima actualización 22/07/2019 21:30                     **/
/**                             Examen Axoft                                 **/
/******************************************************************************/
import 'package:flutter/material.dart';
import 'WebView.dart';                                                          //Importo WebView

//procedimiento encargado de definir al Widget MyApp como root
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter Axoft',                                            //Titulo descriptivo
      debugShowCheckedModeBanner: false,                                        //Con esto sacamos el banner de Debug Mode
      home: WebView(),                                                          //Defino como Widget principal al WebView
    );
  }
}




