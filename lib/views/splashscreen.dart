import 'package:flutter/material.dart';
import 'package:weather_app/views/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;
  double _translateY = 20;
  List<double> letterOpacity = List.filled(9, 0.0); // 9 letters in "WEATHERLY"

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.05;
        _translateY = 0;
      });

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _scale = 1.0;
        });
      });
    });

    for (int i = 0; i < letterOpacity.length; i++) {
      Future.delayed(Duration(milliseconds: 300 + (i * 200)), () {
        setState(() {
          letterOpacity[i] = 1.0;
        });
      });
    }

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double logoSize = MediaQuery.of(context).size.width * 0.4;
    String appName = "WEATHERLY";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF6B6B), Color(0xFFFFD166), Color(0xFF4A90E2)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                opacity: _opacity,
                child: AnimatedScale(
                  scale: _scale,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOut,
                    transform: Matrix4.translationValues(0, _translateY, 0),
                    child: Container(
                      child: Container(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/logo.jpg',
                          width: logoSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(appName.length, (index) {
                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: letterOpacity[index],
                    child: Text(
                      appName[index],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
