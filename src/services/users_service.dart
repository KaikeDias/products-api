import '../data/fake_data.dart';
import '../models/user_model.dart';
import 'user_exception.dart';

class UsersService {
  Future<List<UserModel>> findAllUsers() async {
    await Future.delayed(Duration(milliseconds: 50));
    final List<UserModel> allUsers =
        users.map((userMap) => UserModel.fromMap(userMap)).toList();

    if (allUsers.isEmpty) {
      throw EmptyUserList();
    }

    return allUsers;
  }

  Future<UserModel> authenticateUserService(UserModel userModel) async {
    await Future.delayed(Duration(milliseconds: 50));

    final List<UserModel> allUsers =
        users.map((userMap) => UserModel.fromMap(userMap)).toList();

    try {
      final UserModel selectedUser = allUsers.firstWhere(
        (user) =>
            user.username == userModel.username &&
            user.email == userModel.email &&
            user.password == userModel.password,
      );

      return selectedUser;
    } on StateError {
      throw UserNotFound();
    }
  }

  Future<UserModel> registerUserService(UserModel userModel) async {
    await Future.delayed(Duration(milliseconds: 50));

    final Map<String, dynamic> newUserModel = userModel.toMap();

    users.add(newUserModel);

    return UserModel.fromMap(newUserModel);
  }
}
