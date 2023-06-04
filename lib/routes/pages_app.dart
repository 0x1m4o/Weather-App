import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/pages/searchpage.dart';

class AppPages {
  static final routes = {
    '/home': (context) => HomePage(),
    '/search': (context) => SearchPage(),
  };
}
