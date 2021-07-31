import 'package:untitled2/models/login_request.dart';
import 'package:untitled2/models/login_response.dart';
import 'package:untitled2/models/message_response.dart';
import 'package:untitled2/models/signup_request.dart';
import 'package:untitled2/service/users/users_api_provider.dart';

class UsersRepository {
  UsersApiProvider _provider = UsersApiProvider();

  Future<MessageResponse> signup(SignupRequest param) =>
      _provider.postSignUp(param);

  Future<LoginResponseModel> login(LoginRequestModel param) =>
      _provider.postLogin(param);

  Future<bool> logout() => _provider.getLogout();
}
