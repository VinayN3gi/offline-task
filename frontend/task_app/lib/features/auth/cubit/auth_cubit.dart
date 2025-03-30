import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/services/sp_services.dart';
import 'package:task_app/features/auth/repository/auth_remote_repository.dart';
import 'package:task_app/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //The intial state
  AuthCubit() : super(AuthUserIntial());

  //Instance of authRemoteRepository
  final authRemoteRepository = AuthRemoteRepository();
  final spService = SpService();

  void signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      emit(AuthLoading());

      await authRemoteRepository.signUp(
          name: name, email: email, password: password);

      emit(AuthSignUp());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      final user =
          await authRemoteRepository.login(email: email, password: password);

      if (user.token.isNotEmpty) {
        await spService.setToken(user.token);
      }

      emit(AuthUserLoggedIn(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void getUser() async {
    try {
      emit(AuthLoading());
      final user = await authRemoteRepository.getUser();
      print(user);
      if (user != null) {
        emit(AuthUserLoggedIn(user));
      } else {
        emit(AuthUserIntial());
      }
    } catch (e) {
      emit(AuthUserIntial());
    }
  }
}
