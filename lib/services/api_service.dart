import 'package:dio/dio.dart';

import '../models/post.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  ApiService() : _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  /// Fetches a list of posts from the JSONPlaceholder API
  Future<List<Post>> getPosts() async {
    try {
      final response = await _dio.get('/posts');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server response timeout. Please try again.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      } else {
        throw Exception('Failed to fetch posts: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  /// Fetches a single post by ID
  Future<Post> getPostById(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      
      if (response.statusCode == 200) {
        return Post.fromJson(response.data);
      } else {
        throw Exception('Failed to load post: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch post: ${e.message}');
    }
  }
}
