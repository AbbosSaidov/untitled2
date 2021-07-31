import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:get/route_manager.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key, this.backButton=true, this.isSearch=true}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final bool backButton; // default is 56.0
  final bool isSearch; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar( toolbarHeight: 56,
      titleSpacing: 0,
      elevation: 1,
      automaticallyImplyLeading: widget.backButton,
      backgroundColor:  MyColors.bigStone,
      title: Container(
        height: 42,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(),
            ),
            // Container(
            //   width: 40,
            //   margin: EdgeInsets.only(left: 7, right: 8),
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(50),
            //     onTap: () => {
            //       // Get.toNamed("/search")
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            //       child: Text(""),
            //       // Text(
            //       //   "anti virus".toUpperCase(),
            //       //   style: TextStyle(color: MyColors.white, fontSize: 9),
            //       //   overflow: TextOverflow.ellipsis,
            //       //   maxLines: 2,
            //       //   softWrap: false,
            //       //   textAlign: TextAlign.center,
            //       // ),
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 92,
              child: widget.isSearch ?InkWell(
                onTap: () => {Get.toNamed("/search")},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: MyColors.white,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => {Get.toNamed("/search")},
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        icon: Icon(Icons.search, color: Colors.black45),
                      ),
                      Expanded(
                        child: Text(
                          "Искать...",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      // SizedBox(
                      //   width: 35,
                      //   child: IconButton(
                      //     padding: EdgeInsets.all(0),
                      //     onPressed: () => {
                      //       _speechTotext(),
                      //     },
                      //     icon: Icon(
                      //       Icons.mic_none_outlined,
                      //       color: MyColors.bigStone,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 35,
                      //   child: IconButton(
                      //     padding: EdgeInsets.all(0),
                      //     onPressed: () => {},
                      //     icon: Icon(
                      //       Icons.camera_alt_outlined,
                      //       color: MyColors.bigStone,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
              ) :Container(),
            ),
            Expanded(
              flex: 4,
              child: Container(),
            ),
          ],
        ),
      ),);
  }
}
class AppBarWidget extends AppBar{
  AppBarWidget():super(
    toolbarHeight: 56,
    titleSpacing: 0,
    elevation: 1,
    backgroundColor:  MyColors.bigStone,
    title: Container(
      height: 42,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(),
          ),
          // Container(
          //   width: 40,
          //   margin: EdgeInsets.only(left: 7, right: 8),
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(50),
          //     onTap: () => {
          //       // Get.toNamed("/search")
          //     },
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          //       child: Text(""),
          //       // Text(
          //       //   "anti virus".toUpperCase(),
          //       //   style: TextStyle(color: MyColors.white, fontSize: 9),
          //       //   overflow: TextOverflow.ellipsis,
          //       //   maxLines: 2,
          //       //   softWrap: false,
          //       //   textAlign: TextAlign.center,
          //       // ),
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 92,
            child: InkWell(
              onTap: () => {Get.toNamed("/search")},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: MyColors.white,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => {Get.toNamed("/search")},
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      icon: Icon(Icons.search, color: Colors.black45),
                    ),
                    Expanded(
                      child: Text(
                        "Искать...",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                    // SizedBox(
                    //   width: 35,
                    //   child: IconButton(
                    //     padding: EdgeInsets.all(0),
                    //     onPressed: () => {
                    //       _speechTotext(),
                    //     },
                    //     icon: Icon(
                    //       Icons.mic_none_outlined,
                    //       color: MyColors.bigStone,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 35,
                    //   child: IconButton(
                    //     padding: EdgeInsets.all(0),
                    //     onPressed: () => {},
                    //     icon: Icon(
                    //       Icons.camera_alt_outlined,
                    //       color: MyColors.bigStone,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 10)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(),
          ),
        ],
      ),
    ),
  );
}