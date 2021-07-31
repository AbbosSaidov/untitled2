import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';

class PurchasedGoods extends StatefulWidget {
  @override
  _PurchasedGoodsState createState() => _PurchasedGoodsState();
}

class _PurchasedGoodsState extends State<PurchasedGoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Купленный товары",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      child: Text(
                    "Купленный товары",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )),
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(child: Text('0 товаров')),
                )),
            Expanded(
                child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Список пуст',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Добавлайте товары в список из\nИзбранного'),
                  SizedBox(height: 10),
                  Container(
                    color: Color.fromRGBO(242, 243, 245, 1),
                    child: FlatButton(
                      onPressed: () => {},
                      child: Text(
                        'В избранное',
                        style: TextStyle(color: MyColors.customBlue),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
