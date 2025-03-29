import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/auth/repository/auth_remote_repository.dart';
import 'package:task_app/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //The intial state
  AuthCubit() : super(AuthUserIntial());

  //Instance of authRemoteRepository
  final authRemoteRepository = AuthRemoteRepository();

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
      final user = await authRemoteRepository.login(email: email, password: password);
      emit(AuthUserLoggedIn(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
