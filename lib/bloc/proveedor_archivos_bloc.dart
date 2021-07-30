import 'package:bloc/bloc.dart';
import 'package:proveedores_de_archivos/file_providers/proveedor_archivos.dart';
import 'package:proveedores_de_archivos/models/archivo.dart';

class ProveedorArchivosBloc
    extends Bloc<ProveedorArchivosEvento, ProveedorArchivosEstado> {

  ProveedorArchivos _proveedorArchivos;

  ProveedorArchivosBloc(this._proveedorArchivos) : super(NoInicializado());

  ProveedorArchivos proveedor() => _proveedorArchivos;

  @override
  Stream<ProveedorArchivosEstado> mapEventToState(
      ProveedorArchivosEvento event) async*{
    if (event is Inicializar) {
      yield* _inicializar();
    }
  }

  inicializar() => this.add(Inicializar());
  Stream<ProveedorArchivosEstado> _inicializar() async* {
    yield Cargando();
    await _proveedorArchivos.authorizar();
    List<Archivo> archivos = await _proveedorArchivos.listar();
    yield Listo(archivos);
  }
}

abstract class ProveedorArchivosEstado {}

class NoInicializado extends ProveedorArchivosEstado {}

class Cargando extends ProveedorArchivosEstado {}

class Listo extends ProveedorArchivosEstado {
  List<Archivo> archivos;

  Listo(this.archivos);
}

abstract class ProveedorArchivosEvento {}

class Inicializar extends ProveedorArchivosEvento {}

//EVE -> { BLOC } -> EST
