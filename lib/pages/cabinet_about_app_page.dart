import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){Navigator.pop(context);},),
        title: Text("O приложении", style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ashop", style: TextStyle(fontSize: 30.0, color: MyColors.customBlue),),
                SizedBox(height: 15.0),
                Text("Версия 1.0.0"),
                SizedBox(height: 15.0),
                Text("Интернет-магазин Аshop.uz"),
                SizedBox(height: 10.0),
                Text("Более 15 000 000 товаров")
              ],
            )
          ),
          Expanded(child: SizedBox()),
          Center(
            child: Text("Лицензионное соглашение", style: TextStyle(color: MyColors.customBlue),),
          ),
          SizedBox(height: 20.0,),

        ],
      ),
    );
  }
}
