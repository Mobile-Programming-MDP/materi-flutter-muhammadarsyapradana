import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/services/api_services.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen ({super.key});

  @override 
  State<HomeScreen> createState() => _HomeScreenState();
}

class_HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Movie> _allMovie = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async{
    final List<Map<String, dynamic>> allMoviesData = await _apiService.getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesData = await _apiService.getTrendingMoving();
    final List<Map<String, dynamic>> PopularMovingData = await _apiService.getPopularMoving();


    setState(() {
      _allMovie = allMoviesData.map((e)=> Movie.fromJson(e)).toList();
      _trendingMovies = trendingMoviesData.map((e)=> Movie.fromJson(e)).toList();
      _popularMovies = PopularMovingData.map((e)=> Movie.fromJson(e)).toList();
    })
  }
}