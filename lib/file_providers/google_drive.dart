import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/adsense/v1_4.dart';
import 'package:googleapis/drive/v3.dart' as google;
import 'package:proveedores_de_archivos/file_providers/proveedor_archivos.dart';
import 'package:proveedores_de_archivos/models/archivo.dart';
import 'package:proveedores_de_archivos/utils/cliente_autorizado.dart';
import 'package:path_provider/path_provider.dart';

class GoogleDrive extends ProveedorArchivos {

  GoogleSignInAccount? _cuenta;
  late google.DriveApi _driveApi;

  GoogleDrive() : super("Google Drive");

  @override
  authorizar() async {
    //Inicializamos la configuracion de inicio de sesion
    final googleSignIn = GoogleSignIn.standard(
        scopes: [google.DriveApi.driveScope]);

    //Authorizamos
    _cuenta = await googleSignIn.signIn();

    if (_cuenta == null) {
      print("El usuario no autorizó");
    } else {
      //Inicializamos DriveAPI
      final client = ClienteAuthorizado(await _cuenta!.authHeaders);
      _driveApi = google.DriveApi(client);
    }
  }

  @override
  listar() async {
    List<Archivo> archivos = [];

    google.FileList gArchivos = await _driveApi.files.list();
    if (gArchivos.files != null) {
      archivos.addAll(
          gArchivos.files!.map((file) => Archivo.desdeGoogle(file)));
    }

    return archivos;
  }

  @override
  descargar(Archivo archivo) {
    print('Descargando archivo $archivo');
    final referencia = archivo.referencia as google.File;
    _driveApi.files.get(
      referencia.id!, downloadOptions: DownloadOptions.fullMedia)
        .then((media) {
       if (media is google.Media) {
         var bytes = <int>[];
         media.stream.listen((data) {
           print('Agregando datos al archivo');
           bytes.insertAll(bytes.length, data);
         }, onDone: () async {
           final directorio = await getExternalStorageDirectory();
           final file = new File(directorio!.path + '/' + referencia.name!);

           file.writeAsBytesSync(bytes);

           print('Descarga completa, ruta: ' + file.path);
         });
       } else {
         print('Descarga fallida');
       }
    });
  }

}