part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersEmptyState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSignupLoadedState extends UsersState {
  final MessageResponse signUpResult;
  UsersSignupLoadedState({@required this.signUpResult})
      : assert(signUpResult != null);
}

class UsersLoginLoadedState extends UsersState {
  final LoginResponseModel res;
  UsersLoginLoadedState({@required this.res}) : assert(res != null);
}

class UsersLogoutLoadedState extends UsersState {}

class UsersErrorState extends UsersState {
  final String message;
  UsersErrorState({this.message});
}
