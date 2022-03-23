part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckAuth extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final UserModel userModel;

  LoggedIn(this.userModel);
}

class LoggedOut extends AuthEvent {}
