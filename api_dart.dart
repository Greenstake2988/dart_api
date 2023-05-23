import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;



void main() async {
  final app = Router();

  app.get('/', (Request request) {
    return Response.ok('Raiz App');
  });

  app.mount('/users/', userRouter());

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(app);
  final server = await shelf_io.serve(handler, 'localhost', 8080);
  print('Servidor en ejecución en ${server.address.host}:${server.port}');
}




Router userRouter() {
  final router = Router();

  router.get('/', (Request request) {
    return Response.ok('Raiz de users');
  });

  router.get('/<id>', (Request request) {
    final userID = request.params['id'];
    return Response.ok('ID Usuario: $userID');
  });
  

  return router;
}
