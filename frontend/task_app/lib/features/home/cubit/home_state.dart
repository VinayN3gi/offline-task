part of "home_cubit.dart";

sealed class HomeState {
  const HomeState();
}

final class HomeIntial extends HomeState {}

final class HomeError extends HomeState {
  final String error;
  const HomeError(this.error);
}

final class HomeSuccess extends HomeState {
  final TaskModel taskModel;
  const HomeSuccess(this.taskModel);
}


final class HomeLoading extends HomeState{}