part of "auth_cubit.dart";

sealed class AuthState {}

final class AuthUserIntial extends AuthState {}

final class AuthUserLoggedIn extends AuthState {
  //This state will have the users information
  final UserModel user;

  AuthUserLoggedIn(this.user);
}

final class AuthSignUp extends AuthState{}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
