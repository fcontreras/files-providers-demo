import 'package:googleapis/drive/v3.dart' as google;

class Archivo {
  final String nombre;
  final Object referencia;
  final bool esDirectorio;

  Archivo(this.nombre, this.referencia, this.esDirectorio);

  factory Archivo.desdeGoogle(google.File file) {
    return Archivo(file.name!, file, file.mimeType == 'application/vnd.google-apps.folder');
  }

  @override
  String toString() {
    return nombre;
  }
}