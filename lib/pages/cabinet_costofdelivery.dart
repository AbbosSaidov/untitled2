import 'package:flutter/material.dart';

class CabinetCostOfDelivery extends StatefulWidget {
  @override
  _CabinetCostOfDeliveryState createState() => _CabinetCostOfDeliveryState();
}

class _CabinetCostOfDeliveryState extends State<CabinetCostOfDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded), color: Colors.black, onPressed: (){
          Navigator.pop(context);
        },
        ),
        title: Text("Стоимость доставки", style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color.fromRGBO(233,237,240, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Адрес получения'),
                      SizedBox(height: 4.0),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Москва', style: TextStyle(color: Colors.black),),
                              Icon(Icons.arrow_drop_down_sharp, color: Colors.black,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text('Пункты выдачи и постаматы', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
 