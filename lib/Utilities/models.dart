/*
                          

{
  
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
  },
  
  
  "name": "Mountain View",
  "cod": 200
  }                         

                        
*/

class WeatherResponse {
  final String cityName;

  WeatherResponse({required this.cityName});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    return WeatherResponse(cityName: cityName);
  }
}
