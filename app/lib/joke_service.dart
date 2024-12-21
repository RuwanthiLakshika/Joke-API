import 'package:dio/dio.dart';

class JokeServices {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchLokeRaw() async {
    try {
      final response =
          await _dio.get('https://v2.jokeapi.dev/joke/Any?amount=3');
      if (response.statusCode == 200) {
        final List<dynamic> jokesJson = response.data['jokes'];
        return jokesJson.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      throw Exception('Error fetching jokes: $e');
    }
  }
}
