abstract class UserException {
  final String message;

  const UserException({required this.message});
}

class UserNotFound extends UserException {
  UserNotFound() : super(message: 'User not found');
}

class EmptyUserList extends UserException {
  EmptyUserList()
      : super(message: 'No user records were found in the database');
}

class PasswordMismatch extends UserException {
  PasswordMismatch()
      : super(message: "Password and confirmation password do not match");
}
