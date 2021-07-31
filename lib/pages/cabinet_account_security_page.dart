import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/extensions/hex_color.dart';

class AccountSecurity extends StatefulWidget {
  @override
  _AccountSecurityState createState() => _AccountSecurityState();
}

class _AccountSecurityState extends State<AccountSecurity> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Аккаунт и безопасность",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(242, 243, 245, 1),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(242, 243, 245, 1),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 16.0, 8.0),
                child: Text(
                  "Быстрый вход",
                  style: TextStyle(color: Color.fromRGBO(137, 148, 154, 1)),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 16.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Google Smart Lock")),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChecked
                                  ? HexColor("#0757F6")
                                  : Colors.white,
                              border: Border.all(
                                color: isChecked
                                    ? HexColor("#0757F6")
                                    : MyColors.zumthor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                isChecked
                                    ? Icons.check
                                    : Icons.check_box_outline_blank,
                                size: 15,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Использовать данные для входа с помощью\nаккаунта Google",
                      style: TextStyle(color: Color.fromRGBO(93, 109, 121, 1)),
                    ),
                    SizedBox(height: 15.0),
                    Divider(
                      height: 1.0,
                      color: Colors.black38,
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Отключить быстрый вход")),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChecked
                                  ? HexColor("#0757F6")
                                  : Colors.white,
                              border: Border.all(
                                color: isChecked
                                    ? HexColor("#0757F6")
                                    : MyColors.zumthor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                isChecked
                                    ? Icons.check
                                    : Icons.check_box_outline_blank,
                                size: 15,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("Входить с помощью смс"),
                    SizedBox(height: 15.0),
                    Divider(
                      height: 1.0,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(242, 243, 245, 1),
              width: double.infinity,
              height: 30.0,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 16.0, 12.0),
                child: Center(
                    child: Text(
                  "Быйти на этом устройстве",
                  style: TextStyle(color: Colors.red),
                )),
              ),
            ),
            Container(
              color: Color.fromRGBO(242, 243, 245, 1),
              width: double.infinity,
              height: 20.0,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 16.0, 12.0),
                child: Center(
                    child: Text("Быйти на всех устройствах",
                        style: TextStyle(
                            color: Color.fromRGBO(160, 169, 174, 1)))),
              ),
            ),
            Container(
              color: Color.fromRGBO(242, 243, 245, 1),
              width: double.infinity,
              height: 20.0,
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 12.0, 16.0, 12.0),
                child: Center(
                    child: Text(
                  "Удалить аккаунт",
                  style: TextStyle(color: Color.fromRGBO(160, 169, 174, 1)),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
