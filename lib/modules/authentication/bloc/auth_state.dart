part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLogined;
  const AuthState(this.isLogined);
  factory AuthState.initial() => AuthState(false);
  factory AuthState.loggedIn() => AuthState(true);
  factory AuthState.loggedout() => AuthState(false);
  @override
  List<Object?> get props => [isLogined];
}
