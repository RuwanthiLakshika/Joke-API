import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class JokeService {
  final Dio _dio = Dio();

  // Fetch jokes from API
  Future<List<Map<String, dynamic>>> fetchJokesRaw(String jokeType, int offset) async {
    try {
      final response = await _dio.get('https://v2.jokeapi.dev/joke/$jokeType',
          queryParameters: {
            'amount': 5, 
            'blacklistFlags': 'nsfw',
            'skip': offset,
          });
      if (response.statusCode == 200) {
        final List<dynamic> jokesJson = response.data['jokes'];
        _cacheJokes(jokesJson);  // Cache jokes on successful fetch
        return jokesJson.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      print('Error fetching jokes: $e');
      // Return cached jokes if network request fails
      return _getCachedJokes();
    }
  }

  // Cache jokes in shared_preferences
  Future<void> _cacheJokes(List<dynamic> jokesJson) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jokesString = jsonEncode(jokesJson); // Convert jokes to JSON string
      await prefs.setString('cached_jokes', jokesString); // Store the jokes
    } catch (e) {
      print('Error caching jokes: $e');
    }
  }

  // Get cached jokes from shared_preferences
  Future<List<Map<String, dynamic>>> _getCachedJokes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJokesString = prefs.getString('cached_jokes');
      if (cachedJokesString != null) {
        final List<dynamic> jokesJson = jsonDecode(cachedJokesString);
        return jokesJson.cast<Map<String, dynamic>>();
      }
      return [];  // Return empty list if no cached jokes are found
    } catch (e) {
      print('Error retrieving cached jokes: $e');
      return [];
    }
  }
}
