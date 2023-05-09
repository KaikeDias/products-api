import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../src/controllers/products_controller.dart';
import '../src/controllers/users_controller.dart';
import '../src/services/products_service.dart';
import '../src/services/users_service.dart';

// Configure routes.
final _router = Router();

void main(List<String> args) async {
  final productsService = ProductsService();
  final productsController = ProductController(productsService);
  final usersService = UsersService();
  final usersController = UsersController(usersService);

  _router.get('/products', productsController.getAllProducts);
  _router.get('/products/<id>', productsController.getProductById);
  _router.post('/products', productsController.createProduct);

  _router.get('/users', usersController.getAllUsers);
  _router.post('/users', usersController.authenticateUser);
  _router.post('/users/register', usersController.registerUser);

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
