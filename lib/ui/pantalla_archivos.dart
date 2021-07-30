import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proveedores_de_archivos/bloc/proveedor_archivos_bloc.dart';

class PantallaArchivos extends StatefulWidget {
  final String titulo;

  const PantallaArchivos({Key? key, required this.titulo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PantallaArchivosEstado();
}

class _PantallaArchivosEstado extends State<PantallaArchivos> {
  late ProveedorArchivosBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<ProveedorArchivosBloc>(context);

    super.initState();
    _bloc.inicializar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
      ),
      body: BlocBuilder<ProveedorArchivosBloc, ProveedorArchivosEstado>(
        builder: (context, estado) {
          if (estado is Listo) {
            return ListView.builder(
              itemBuilder: (context, indice) {
                final archivo = estado.archivos.elementAt(indice);

                return ListTile(
                  title: Text(archivo.nombre),
                  leading: archivo.esDirectorio ? Image.asset('assets/folder.png') : Image.asset('assets/file.png'),
                  onTap: () {
                    if(archivo.esDirectorio) {

                    } else {
                      _bloc.proveedor().descargar(archivo);
                    }
                  },
                );
              },
              itemCount: estado.archivos.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
