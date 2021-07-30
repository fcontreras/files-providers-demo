import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proveedores_de_archivos/bloc/proveedor_archivos_bloc.dart';
import 'package:proveedores_de_archivos/file_providers/google_drive.dart';
import 'package:proveedores_de_archivos/ui/pantalla_archivos.dart';

class PantallaHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PatantallaHomeState();
}

class _PatantallaHomeState extends State<PantallaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proveedores de Archivos'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Google Drive'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              final proveedor = GoogleDrive();

              return BlocProvider(
                create: (context) => ProveedorArchivosBloc(proveedor),
                child: PantallaArchivos(titulo: proveedor.title),
              );
            }));
          },
        ),
      ),
    );
  }
}
