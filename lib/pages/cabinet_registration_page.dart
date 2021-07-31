import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/service/users/cubit/users_cubit.dart';

class CabinetPageRegistration extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => screen());

  static Widget screen() => BlocProvider(
      create: (context) => UsersCubit(), child: CabinetPageRegistration());

  @override
  _CabinetPageRegistrationState createState() =>
      _CabinetPageRegistrationState();
}

class _CabinetPageRegistrationState extends State<CabinetPageRegistration> {
  bool chechPhoneNumber = false;
  final TextEditingController _userPhoneNumber = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 243, 245, 1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Text(
                            "Телефон",
                            style: TextStyle(
                              color: !chechPhoneNumber
                                  ? Colors.black38
                                  : Colors.red,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: TextField(
                            controller: _userPhoneNumber,
                            keyboardType: TextInputType.number,
                            onChanged: (string) {},
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.0, 0, 16.0, 0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: chechPhoneNumber
                      ? Text(
                          "Некорректный формат телефона",
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox(
                          height: 1.0,
                        )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 16.0, 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    color: Color.fromRGBO(0, 91, 254, 1),
                    onPressed: () {
                      setState(() {
                        if (_userPhoneNumber.text == "") {
                          chechPhoneNumber = true;
                        }
                      });
                    },
                    child: Text(
                      "Получить код",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Войти по почте",
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ),
          ]),
    );
  }
}
