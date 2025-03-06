import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/providers/connectivity_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  bool isChanged = pref.getBool('isthemechanged') ?? false;

  runApp(MyApp(isChanged: isChanged));
}

class MyApp extends StatelessWidget {
  final bool isChanged;
  const MyApp({super.key, required this.isChanged});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(isChanged)),
        ChangeNotifierProvider(create: (context) => Internetprovider()),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.isdark ? ThemeMode.dark : ThemeMode.light,
            routes: {'/': (context) => SplashScreen()},
          );
        },
      ),
    );
  }
}
