import 'package:bloc/bloc.dart';
import 'package:untitled2/models/login_request.dart';
import 'package:untitled2/models/login_response.dart';
import 'package:untitled2/models/message_response.dart';
import 'package:untitled2/models/signup_request.dart';
import 'package:untitled2/service/users/users_repository.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepository repository = UsersRepository();

  UsersCubit() : super(UsersEmptyState());

  Future<void> signup(SignupRequest param) async {
    try {
      emit(UsersEmptyState());

      final MessageResponse mes = await repository.signup(param);

      emit(UsersSignupLoadedState(signUpResult: mes));
    } catch (e) {
      emit(UsersErrorState(message: "$e"));
    }
  }

  Future<void> login(LoginRequestModel param) async {
    try {
      emit(UsersEmptyState());

      final LoginResponseModel mes = await repository.login(param);

      emit(UsersLoginLoadedState(res: mes));
    } catch (_) {
      emit(UsersErrorState());
    }
  }

  Future<void> logout() async {
    try {
      emit(UsersEmptyState());

      final _ = await repository.logout();

      emit(UsersLogoutLoadedState());
    } catch (_) {
      emit(UsersErrorState());
    }
  }
}
