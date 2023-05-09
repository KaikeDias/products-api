import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../models/user_model.dart';
import '../services/user_exception.dart';
import '../services/users_service.dart';

class UsersController {
  final UsersService _usersService;

  UsersController(this._usersService);

  FutureOr<Response> getAllUsers(Request request) async {
    try {
      final List<UserModel> allUsers = await _usersService.findAllUsers();

      return Response.ok(
          jsonEncode({
            'users':
                allUsers.map((user) => user.toMapWithoutPassword()).toList(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } on UserException catch (e) {
      return Response.notFound(
        jsonEncode({
          'error': e.message,
        }),
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }

  FutureOr<Response> authenticateUser(Request request) async {
    final String body = await request.readAsString();
    final Map<String, dynamic> userData = jsonDecode(body);
    final UserModel userModel = UserModel.fromMap(userData);

    try {
      final UserModel selectedUser =
          await _usersService.authenticateUserService(userModel);

      return Response.ok(
          jsonEncode({
            'user': selectedUser.toMapWithoutPassword(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } on UserException catch (e) {
      return Response.notFound(
        jsonEncode({
          'error': e.message,
        }),
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }

  FutureOr<Response> registerUser(Request request) async {
    final String body = await request.readAsString();
    final Map<String, dynamic> userData = jsonDecode(body);
    final UserModel userModel = UserModel.fromMap(userData);

    try {
      final UserModel newUser =
          await _usersService.registerUserService(userModel);

      return Response.ok(
          jsonEncode({
            'user': newUser.toMapWithoutPassword(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': e.toString(),
        }),
      );
    }
  }
}
