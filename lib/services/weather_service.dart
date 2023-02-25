import '../API_KEY.dart';

class WeatherServices {
  static const WEATHER_API_URL =
      "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/";

  static Future<String> getWeather(String location) async {
    String url = "$WEATHER_API_URL$location/$WEATHER_API_TOKEN";
    return "Something";
  }
}
