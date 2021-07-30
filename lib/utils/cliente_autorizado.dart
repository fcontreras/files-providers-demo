import 'package:http/http.dart';

class ClienteAuthorizado extends BaseClient {

  final Map<String, String> _encabezados;
  final Client _cliente = Client();

  ClienteAuthorizado(this._encabezados);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _cliente.send(request..headers.addAll(_encabezados));
  }

}