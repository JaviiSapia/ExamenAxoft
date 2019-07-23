import 'package:flutter/material.dart';
import 'MessageView.dart';                                                      //Importo MessageView
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';            //Libreria que me brinda la herramientas webView

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  //Creo un FlutterWebviewPlugin general para escuchar todos los eventos del webView
  final FlutterWebviewPlugin _flutterWebviewPlugin = new FlutterWebviewPlugin();
  final String _home = "https://nexo.axoft.com/Account/LogOnApp/0";             //Guardo en este string la direccion que se mostrara inicialmente
  final String _profile = "https://nexo.axoft.com/profile";                     //Guardo en este string la direccion del perfil que se redireccionara mas tarde
  String _title;                                                                //Variable que utilizo para alterar el texto del AppBar
  String _url;                                                                  //Variable que utilizo para redireccionar al WebView
  BuildContext _webContext;                                                     //Guardo en este BuilContext el context del WebView para despues utilizar como atributo para el AlertDialog

  _WebViewState(){                                                              //Constructor
    _title = "Inicio";                                                          //Definio inicialmente que el AppBar mostrará "Inicio"
    _url = _home;                                                               //Inicialmente me dirijo a la pantalla de loggeo
    onUrlChangeListener();                                                      //Escucho los cambios de URL (Redirecciones)
  }

  //Procedimiento encargado de mostrar el AlertDialog y escuchar las redirecciones
  onUrlChangeListener(){
    Uri _uri;                                                                   //Creo esta variable temporalmente para obtener los query string parameters

    //Evento de cambio de URL
    _flutterWebviewPlugin.onUrlChanged.listen(
      (String url){
        _uri = Uri.parse(url);

        //Detengo la carga de la pagina para que no se redireccione
        _flutterWebviewPlugin.stopLoading().whenComplete((){

          //Si el usuario desloggea, automaticamente lo redirecciono a la pagina de inicio
          if(url.compareTo("https://nexo.axoft.com/Account/SignOut") == 0){
            changeUrl(_home);
          }

          //Si los parametros no son nulos entonces abro el AlertDialog
          if(_uri.queryParameters['token'] != null && _uri.queryParameters['user'] != null){

            //Escondo el WebView
            _flutterWebviewPlugin.hide();

            //Espero que el usuario acepte el AlertDialog para cambiar la pantalla al perfil
            messageAlert(this._webContext, _uri.queryParameters['token'], _uri.queryParameters['user']).whenComplete((){

              //Una vez que el usuario acepta, voy al perfil
              goProfile();
            });
          }
        });
      }
    );
  }

  //Procedimiento encargado de redireccionar el WebView a la pagina del Perfil y cambiar el nombre del AppBar a Perfil
  goProfile(){
    changeUrl(this._profile);
    this._title = "Perfil";
  }

  //Procedimiento encargado de cambiar la URL del WebView
  changeUrl(String url){
    _url = url;

    //Una vez cargada la pagina, muestro el navegador
    _flutterWebviewPlugin.reloadUrl(url).whenComplete((){
      _flutterWebviewPlugin.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    //Guardo el contexto del Widget para luego utilizarlo en el AlertDialog
    this._webContext = context;
    return WebviewScaffold(
      url: _url,                                                                //URL a la que me quiero dirigir
      withZoom: false,                                                          //Deshabilito el zoom in en el WebView
      withJavascript: true,                                                     //Habilito JavaScript para que la pagina pueda mostrar los mensajes de alerta
      appBar: AppBar(
        title: Text(_title)
      ),
    );
  }
}
