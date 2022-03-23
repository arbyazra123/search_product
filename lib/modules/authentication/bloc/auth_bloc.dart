import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_product/modules/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<CheckAuth>((event, emit) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var user = pref.getString("user");
      if (user == null) {
        emit(AuthState.loggedout());
      } else {
        emit(AuthState.loggedIn());
      }
    });
    on<LoggedIn>((event, emit) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("user", jsonEncode(event.userModel.toJson()));
      emit(AuthState.loggedIn());
    });
    on<LoggedOut>((event, emit) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("user");
      emit(AuthState.loggedout());
    });
  }
}
