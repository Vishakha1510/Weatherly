import 'package:flutter/material.dart';
import 'package:weather_app/helpers/bookmark_helper.dart';

class SavedCitiesScreen extends StatefulWidget {
  @override
  _SavedCitiesScreenState createState() => _SavedCitiesScreenState();
}

class _SavedCitiesScreenState extends State<SavedCitiesScreen> {
  List<String> savedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCities();
  }

  Future<void> _loadSavedCities() async {
    List<String> cities = await PreferencesHelper.getSavedCities();
    setState(() {
      savedCities = cities;
    });
  }

  Future<void> _removeCity(String city) async {
    await PreferencesHelper.removeCity(city);
    _loadSavedCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Saved Cities',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body:
          savedCities.isEmpty
              ? _buildEmptyState()
              : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: savedCities.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(savedCities[index]),
                      direction: DismissDirection.endToStart,
                      onDismissed:
                          (direction) => _removeCity(savedCities[index]),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      child: Card(
                        color: Colors.white,
                        elevation: 6,
                        shadowColor: Colors.blue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 18,
                          ),
                          title: Text(
                            savedCities[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeCity(savedCities[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border, size: 90, color: Colors.blueAccent),
          SizedBox(height: 15),
          Text(
            "No saved cities",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }
}
