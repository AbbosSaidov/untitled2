import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/pages/home_page.dart';
import 'package:untitled2/sharepreference/share_preference.dart';
import 'package:untitled2/models/login_request.dart';
import 'package:untitled2/models/login_response.dart';
import 'package:untitled2/models/signup_request.dart';
import 'package:untitled2/service/users/cubit/users_cubit.dart';
import 'package:untitled2/service/users/users_repository.dart';
import 'package:untitled2/utils/colors.dart';

import 'cabinet_registration_page.dart';

class CabinetPageRegistrationEmail extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => screen());

  static Widget screen() => BlocProvider(
        create: (context) => UsersCubit(),
        child: CabinetPageRegistrationEmail(),
      );

  @override
  _CabinetPageRegistrationEmailState createState() =>
      _CabinetPageRegistrationEmailState();
}

class _CabinetPageRegistrationEmailState
    extends State<CabinetPageRegistrationEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checkName = false;
  bool checkEmail = false;
  bool checkPassword = false;
  bool checkComfirmPassword = false;
  final TextEditingController _userEmail = new TextEditingController();
  final TextEditingController _userName = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _comfirmPassword = new TextEditingController();
  bool _passwordVisible = false;
  bool _comfirmVisible = false;
  double inputHeight = 45;
  double inputSpace = 10;

  final scaffoldState = GlobalKey<ScaffoldState>();

  //
  UsersRepository repo = UsersRepository();

  UsersCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of<UsersCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    _userName.dispose();
    _userEmail.dispose();
    _password.dispose();
    _comfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        backgroundColor: Colors.white,
        body: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UsersLoginLoadedState) {
              SharePreference sharePreference = SharePreference();
              sharePreference.saveValue("name", _userName.text);
              sharePreference.saveValue("email", _userEmail.text);
              sharePreference.saveValue("password", _password.text);
              // // String name = await sharePreference.get("name");
              Navigator.pop(context);
            }
            if (state is UsersErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return Stack(children: <Widget>[
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: [
                      Align(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Center(
                        child: Text("Вход или регистрация"),
                      ),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: Text(
                            "Только для зарегистрированных пользователей",
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: (checkName)
                                      ? inputHeight + 26
                                      : inputHeight,
                                  child: TextFormField(
                                    controller: _userName,
                                    keyboardType: TextInputType.text,
                                    validator: validateName,
                                    onChanged: (string) {},
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Name",
                                      border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: inputSpace),
                                Container(
                                  height: (checkEmail)
                                      ? inputHeight + 26
                                      : inputHeight,
                                  child: TextFormField(
                                    controller: _userEmail,
                                    keyboardType: TextInputType.text,
                                    validator: validateEmail,
                                    onChanged: (string) {},
                                    decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Email",
                                      border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: inputSpace),
                                Container(
                                  height: (checkPassword)
                                      ? inputHeight + 22
                                      : inputHeight,
                                  child: TextFormField(
                                    controller: _password,
                                    keyboardType: TextInputType.text,
                                    validator: validatePassword,
                                    onChanged: (string) {},
                                    decoration: new InputDecoration(
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black38,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      hintText: "Password",
                                      border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                    ),
                                    obscureText: !_passwordVisible,
                                  ),
                                ),
                                SizedBox(height: inputSpace),
                                Container(
                                  color: Colors.white,
                                  height: (checkComfirmPassword)
                                      ? inputHeight + 22
                                      : inputHeight,
                                  child: TextFormField(
                                    controller: _comfirmPassword,
                                    keyboardType: TextInputType.text,
                                    validator: validateConPass,
                                    onChanged: (string) {},
                                    decoration: new InputDecoration(
                                      hintText: "Confirm Passpord",
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _comfirmVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black38,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _comfirmVisible = !_comfirmVisible;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black54),
                                        borderRadius:
                                            BorderRadius.circular(25.7),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                    ),
                                    obscureText: !_comfirmVisible,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24.0, 0, 16.0, 0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: (checkEmail ||
                                    checkName ||
                                    checkPassword ||
                                    checkPassword ||
                                    checkComfirmPassword)
                                ? Text(
                                    "Данные не заполнены",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : SizedBox(
                                    height: 1.0,
                                  )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              color: MyColors.customBlue,
                              onPressed: _onPress,
                              child: Text(
                                "Регистрация",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CabinetPageRegistration(),
                          ),
                        );
                      },
                      child: Text(
                        "Вернуться на главный экран",
                        style: TextStyle(color: MyColors.customBlue),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          },
        ),
      ),
    );
  }

  String validateName(String value) {
    String patern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patern);
    if (value.length == 0) {
      checkName = true;
      return "Имя обязательно";
    } else if (!regExp.hasMatch(value)) {
      checkName = true;
      return "Имя должно быть от a-z и от A-Z";
    }
    checkName = false;
    return null;
  }

  String validateEmail(String email) {
    if (email != null && email.length > 100) {
      checkEmail = true;
      return 'Электронная почта не может содержать более 100 символов';
    }

    if (email == null || !email.contains("@")) {
      checkEmail = true;
      return "Недействительный адрес электронной почты";
    }
    checkEmail = false;
    return null;
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      checkPassword = true;
      return "Необходим пароль";
    } else if (value.length < 6) {
      checkPassword = true;
      return "Пароль Должно быть больше 6";
    }
    checkPassword = false;
    return null;
  }

  String validateConPass(String value) {
    var password = _password.text;

    if (value.length == 0) {
      checkComfirmPassword = true;
      return "Необходим пароль";
    } else if (value != password) {
      checkComfirmPassword = true;
      return 'Пароль не совпадает';
    }
    checkComfirmPassword = false;
    return null;
  }

  void _onPress() async {
    var username = _userName.text;
    var email = _userEmail.text;
    var pass = _password.text;
    var comPass = _comfirmPassword.text;

    var param = new SignupRequest();
    param.name = username;
    param.email = email;
    param.password = pass;
    param.passowrdConfirmation = comPass;

    if (_formKey.currentState.validate()) {
      print("$username, $email, $pass, $comPass");
      var res = await repo.signup(param);

      // If all data are correct then save data to out variables
      _formKey.currentState.save();

      if (res != null) {
        print(res.message);

        LoginRequestModel login = LoginRequestModel(
          email: email,
          password: pass,
          rememberMe: true,
        );

        LoginResponseModel status = await repo.login(login);
        if (status != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
            ),
          );
        }
      }
    } else {
      // If all data are not valid then start auto validation.

      setState(() {
        _autoValidate = true;
      });
      throw Exception("Не удалось авторизовать.");
    }

    onChanged();
  }

  void onChanged() {
    setState(() {});
  }
}
