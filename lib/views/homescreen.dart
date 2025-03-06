import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/connectivity_provider.dart';
import 'package:weather_app/views/bookmarked_cities.dart';
import 'package:weather_app/views/detailscreen.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final internetProvider = Provider.of<Internetprovider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'WEATHERLY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedCitiesScreen()),
              );
            },
            icon: Icon(Icons.bookmark, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              onTap: () {},
            ),
            Divider(),
            SwitchListTile(
              title: Text("Theme Mode"),
              secondary: Icon(
                themeProvider.isdark ? Icons.dark_mode : Icons.light_mode,
              ),
              value: themeProvider.isdark,
              onChanged: (value) {
                themeProvider.toogletheme();
              },
            ),
          ],
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _cityController,
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter City',
                      hintStyle: TextStyle(color: Colors.grey.shade700),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.blue),
                        onPressed: () async {
                          if (internetProvider.connectivityResult !=
                              ConnectivityResult.none) {
                            weatherProvider.fetchWeather(_cityController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No internet connection!'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child:
                      (internetProvider.connectivityResult !=
                              ConnectivityResult.none)
                          ? Column(
                            children: [
                              if (weatherProvider.isLoading)
                                CircularProgressIndicator(color: Colors.white),
                              if (weatherProvider.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    weatherProvider.errorMessage!,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if (weatherProvider.weather != null)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => DetailScreen(
                                              weather: weatherProvider.weather!,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: Colors.white.withOpacity(0.9),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            weatherProvider.weather!.city,
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            '${weatherProvider.weather!.temperature}°C',
                                            style: TextStyle(
                                              fontSize: 45,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade800,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons.water_drop,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                  Text(
                                                    '${weatherProvider.weather!.humidity}%',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Humidity',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons.air,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                  Text(
                                                    '${weatherProvider.weather!.windSpeed} m/s',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Wind Speed',
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                          : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.wifi_off,
                                  color: Colors.white70,
                                  size: 80,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "NO INTERNET CONNECTION",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
