import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  //ganti denganAPIkey Maisng-masing
  static const String apiKey ="b41c81bf21262306d8f5b201c5e5905f";
  //1. Mengambil list moving yang saat ini tayang
  Future<List<Map<String, dynamic>>> getAllMovies() 
  async{
    //https://api.themoviedb.org/3/movie/now_playing?api_key=b41c81bf21262306d8f5b201c5e5905f
    final url= Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey");
    final response = await http.get(url);
    final data = json.decode(response.body);
    
    return List<Map<String, dynamic>>.from(data['results']);    
  }

  //2. Mengambil list moving yang sedang trending
  Future<List<Map<String, dynamic>>> getTrendingMoving() 
  async{
    final response = await http.get(Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  //3. Mengambil list populer movie
  Future<List<Map<String, dynamic>>> getPopularMoving() 
  async{
    final response = await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
  //4. Megambil list movie melalui pencarian
  Future<List<Map<String, dynamic>>> searchMovies(String query) 
  async{
    final response = await http.get(Uri.parse("$baseUrl/search/movie?api_key=$apiKey&query=$query"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}