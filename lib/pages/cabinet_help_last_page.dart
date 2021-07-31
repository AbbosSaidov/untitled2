import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';

class CabinetHelpLastPage extends StatefulWidget {
  @override
  _CabinetHelpLastPageState createState() => _CabinetHelpLastPageState();
}

class _CabinetHelpLastPageState extends State<CabinetHelpLastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 243, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Text("Нет информации"),
                  SizedBox(height: 20),
                  Text(
                    'Была ли статья полезной?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Row contents horizontally,
                    children: [
                      Container(
                        color: Color.fromRGBO(242, 243, 245, 1),
                        child: FlatButton(
                          onPressed: () => {},
                          child: Text(
                            'Да',
                            style: TextStyle(color: MyColors.customBlue),
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      Container(
                        color: Color.fromRGBO(242, 243, 245, 1),
                        child: FlatButton(
                          onPressed: () => {},
                          child: Text(
                            'Нет',
                            style: TextStyle(color: MyColors.customBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Color.fromRGBO(242, 243, 245, 1),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Остались вопросы',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Свяжитесь с нашей службой поддержки\nчерез чат.'),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: 50.0,
                color: MyColors.customBlue,
                child: FlatButton(
                  onPressed: () => {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    "Перейти в чат",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
