import 'package:flutter/cupertino.dart';
import 'package:proveedores_de_archivos/ui/pantalla_home.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    Rutas.home: (context) => PantallaHome()
  };
}

class Rutas {
  static const String home = '/home';
}