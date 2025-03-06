class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final double humidity;
  final double windSpeed;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    return WeatherModel(
      city: data['name'],
      temperature: data['main']['temp'].toDouble(),
      description: data['weather'][0]['description'],
      humidity: data['main']['humidity'].toDouble(),
      windSpeed: data['wind']['speed'].toDouble(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        data['sys']['sunrise'] * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000),
    );
  }

  String get formattedSunrise => _formatTime(sunrise);
  String get formattedSunset => _formatTime(sunset);

  String _formatTime(DateTime time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12 == 0 ? 12 : hour % 12;
    String minuteStr = minute < 10 ? '0$minute' : '$minute';
    return '$hour:$minuteStr $period';
  }
}
