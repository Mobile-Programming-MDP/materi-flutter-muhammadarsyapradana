import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/"
  //ganti denganAPIkey Maisng-masing
  static const String apiKey ="......................."
  //1. Mengambil list moving yang saat ini tayang
  Future<List<Map<String, dynamic>>> getAllMovies() 
  async{
    final response = await http.get(Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"),
    );
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
    final response = await http.get(Uri.parse("$baseUrl/movie/popular/?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
  //4. Megambil list movie melalui pencarian
  Future<List<Map<String, dynamic>>> serchMovies(Stringquery) 
  async{
    final response = await http.get(Uri.parse("$baseUrl/movie/popular/?api_key=$apiKey"),
    );
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}