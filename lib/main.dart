import 'package:flutter/material.dart';
import 'package:untitled2/layouts/home_layout.dart';
import 'package:untitled2/pages/search_page.dart';
import 'package:catcher/catcher.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

void main() {
  CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler()],
  );

  CatcherOptions releaseOptions = CatcherOptions(
    DialogReportMode(),
    [
      HttpHandler(
        HttpRequestType.post,
        Uri.parse("https://httpstat.us/200"),
        printLogs: true,
        enableDeviceParameters: true,
        enableApplicationParameters: true,
        enableStackTrace: true,
      )
    ],
  );

  Catcher(
    rootWidget: MyApp(),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

class MyApp extends StatelessWidget {
  final _title = "Marketplace Demo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/search":
            return PageRouteBuilder(pageBuilder: (_, __, ___) => SearchPage());

          default:
            return null;
        }
      },
    /**/home: DoubleBack(
        message: "Нажмите еще раз, чтобы закрыть",
        child: HomeLayout(title: _title),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // fontFamily: "CascadiaCode",
      ),
    );
  }
}