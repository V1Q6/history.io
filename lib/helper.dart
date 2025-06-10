import 'package:flutter/material.dart';


abrirPagina(context, page){
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){return page;}));
}