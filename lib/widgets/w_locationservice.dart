// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// class LocationService{
//   final String key ="AIzaSyAeNBbTuK7BDOFJWE_c93uCluyq03K-Eg4";
// Future<String> getPlaceId(String input) async {
//   final String url =
//       'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

//   var response = await http.get(Uri.parse(url));
//   var json = convert.jsonDecode(response.body);

//    print(json['candidates']); 
//   if (json['candidates'] == null || json['candidates'].isEmpty) {
//     throw Exception('No place ID found for the given input.');
//   }
//   var placeId = json['candidates'][0]['place_id'] as String;
//   print(placeId); 
//   return placeId;
// }

  
 
//    Future<Map<String, dynamic>> getPlace(String input) async {
//     final placeId = await getPlaceId(input);
// print(placeId);
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

//     var response = await http.get(Uri.parse(url));
//     var json = convert.jsonDecode(response.body);
//     var results = json['result'] as Map<String, dynamic>;

//     print(results);
//     return results;
//   }
// }



// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
 
// class LocationService {
//   final String key = 'AIzaSyDRCUR8N7Upq6to_byI9gynQwzZMKYmpqI'; // Replace this with your actual API key

//   Future<String> getPlaceId(String input) async {
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

//     var response = await http.get(Uri.parse(url));
//     var json = convert.jsonDecode(response.body);

//     // if (json['candidates'] == null || json['candidates'].isEmpty) {
//     //   throw Exception('No place ID found for the given input.');
//     // }
 
//     var placeId = json['candidates']['place_id'] as String;
//     print(placeId); 
//     return placeId;
//   }

//   Future<Map<String, dynamic>> getPlace(String input) async {
//     try {
//       print(getPlace(input)); 
//       final placeId = await getPlaceId(input);

//       final String url =
//           'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

//       var response = await http.get(Uri.parse(url));
//       var json = convert.jsonDecode(response.body);

//       var results = json['result'] as Map<String, dynamic>;
//       print(results);

//       return results;
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Error while fetching place details.');
//     }
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String _apiKey;

  LocationService(this._apiKey);

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$_apiKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    print(json['candidates']);
    if (json['candidates'] == null || json['candidates'].isEmpty) {
      throw Exception('No place ID found for the given input.');
    }
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    print(placeId);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results); 
    return results;
  }
}

