import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = 'f2cb4bb2221b0b678dd88f39790e4181';

class WeatherModel {
  late double longitude, latitude;

  Future<dynamic> getCityWeather(String cityName) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are Denied');
      } else {
        Location location = Location();
        await location.getCurrentLocation();
        longitude = location.longitude;
        latitude = location.latitude;
      }
    } else {
      Location location = Location();
      await location.getCurrentLocation();
      longitude = location.longitude;
      latitude = location.latitude;
    }

    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
    var weatherData = await networkHelper.getBodyData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are Denied');
      } else {
        Location location = Location();
        await location.getCurrentLocation();
        longitude = location.longitude;
        latitude = location.latitude;
      }
    } else {
      Location location = Location();
      await location.getCurrentLocation();
      longitude = location.longitude;
      latitude = location.latitude;
    }

    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));
    var weatherData = await networkHelper.getBodyData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
