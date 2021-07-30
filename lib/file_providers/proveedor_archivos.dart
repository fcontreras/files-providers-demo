import 'package:proveedores_de_archivos/models/archivo.dart';

abstract class ProveedorArchivos {

  final String title;

  ProveedorArchivos(this.title);

  authorizar();

  listar();

  descargar(Archivo archivo);

  //cargar();

  //buscar();
}