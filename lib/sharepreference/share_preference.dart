
import 'package:shared_preferences/shared_preferences.dart';

class SharePreference{

   get(String key) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String value = prefs.getString(key);
     return value;
   }

   saveValue(String key, String value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString(key, value);
   }
}