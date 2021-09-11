import 'package:breaking_bad_bad/core/end_points.dart';
import 'package:dio/dio.dart';

class CharacterWebServices {
  static late Dio _dio;
  final String baseUrl = "https://breakingbadapi.com/api";

  CharacterWebServices() {
    BaseOptions options = new BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    _dio = Dio(options);
  }

  static Future<List<dynamic>> getAllCharacters() async {
    try {
      var response = await _dio.get(EndPoint.characters);
      // print('from character web services:: ' + response.data.toString());
      return response.data;
    } catch (error) {
      print('from character web services:: ' + error.toString());
      return [];
    }
  }

  static Future<List<dynamic>> getCharacterQuotes(String characterName) async {
    try {
      var response = await _dio
          .get(EndPoint.quote, queryParameters: {'author': characterName});
      print('from quote web services:: ' + response.data.toString());

      return response.data;
    } catch (error) {
      print('from quote web services:: ' + error.toString());
      return [];
    }
  }
}
