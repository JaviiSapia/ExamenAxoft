import 'package:flutter/material.dart';

//Funcion encargada de mostrar el AlertDialog mostrando la informacion de
//Token y User, ademas de esperar la respuesta del usuario
Future<bool> messageAlert(BuildContext context, String token, String user) async{
  AlertDialog alertDialog =  AlertDialog(
    content: Container(
      width: double.maxFinite,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 11, 0.0, 22),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue,
              size: 120,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45),
            child: Center(
              child: Text(
                "SESIÓN INICIADA",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none
                ),
              ),
            ),
          ),
          info(Icons.person, "USER", user),
          info(Icons.vpn_key, "TOKEN", token),
        ],
      ),
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          goProfile(context);
        },
        child: Text("Continuar")
      ),
    ],
  );

  //Creo una variable como Handler del showDialog
  bool ok = await showDialog(
      context: context,                                                         //Contexto del WebView (home)
      barrierDismissible: false,                                                //Con esto obligamos al usuario a hacer click
      builder: (BuildContext context){
        return alertDialog;
      }
  );
}

//Funcion encargada de devolver un widget Row con un icono e informacion (Titulo, dato)
Widget info(IconData icon, String title, String infoData){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
    child: Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Icon(
            icon,
            color: Colors.black38,
            size: 44,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              Text(
                infoData,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black26,
                  fontSize: 12,
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

//Procedimiento encargado de volver a la vista
void goProfile(BuildContext context){
  Navigator.pop(context, true);
}

