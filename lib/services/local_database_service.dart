import 'package:hive_flutter/hive_flutter.dart';

import '../models/post.dart';

class LocalDatabaseService {
  static const String _postsBoxName = 'posts';
  static const String _cacheTimestampKey = 'cache_timestamp';
  static const Duration _cacheValidDuration = Duration(hours: 1);

  /// Get the posts box
  Future<Box<Post>> _getPostsBox() async {
    if (!Hive.isBoxOpen(_postsBoxName)) {
      return await Hive.openBox<Post>(_postsBoxName);
    }
    return Hive.box<Post>(_postsBoxName);
  }

  /// Save posts to local cache
  Future<void> cachePosts(List<Post> posts) async {
    try {
      final box = await _getPostsBox();

      // Clear existing data
      await box.clear();

      // Save all posts
      for (var post in posts) {
        await box.put(post.id, post);
      }

      // Save timestamp
      final timestampBox = await Hive.openBox('cache_metadata');
      await timestampBox.put(
        _cacheTimestampKey,
        DateTime.now().toIso8601String(),
      );

      print('✅ Cached ${posts.length} posts to local database');
    } catch (e) {
      print('❌ Error caching posts: $e');
      rethrow;
    }
  }

  /// Get cached posts
  Future<List<Post>> getCachedPosts() async {
    try {
      final box = await _getPostsBox();
      final posts = box.values.toList();

      print('📦 Retrieved ${posts.length} posts from cache');
      return posts;
    } catch (e) {
      print('❌ Error getting cached posts: $e');
      return [];
    }
  }

  /// Check if cached data exists
  Future<bool> hasCachedData() async {
    try {
      final box = await _getPostsBox();
      return box.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Check if cache is still valid (not expired)
  Future<bool> isCacheValid() async {
    try {
      final timestampBox = await Hive.openBox('cache_metadata');
      final timestampString = timestampBox.get(_cacheTimestampKey);

      if (timestampString == null) return false;

      final cacheTime = DateTime.parse(timestampString);
      final now = DateTime.now();
      final difference = now.difference(cacheTime);

      final isValid = difference < _cacheValidDuration;
      print(
        '⏰ Cache is ${isValid ? "valid" : "expired"} (age: ${difference.inMinutes} minutes)',
      );

      return isValid;
    } catch (e) {
      print('❌ Error checking cache validity: $e');
      return false;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      final box = await _getPostsBox();
      await box.clear();

      final timestampBox = await Hive.openBox('cache_metadata');
      await timestampBox.delete(_cacheTimestampKey);

      print('🗑️ Cache cleared');
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  /// Get cache timestamp
  Future<DateTime?> getCacheTimestamp() async {
    try {
      final timestampBox = await Hive.openBox('cache_metadata');
      final timestampString = timestampBox.get(_cacheTimestampKey);

      if (timestampString == null) return null;

      return DateTime.parse(timestampString);
    } catch (e) {
      return null;
    }
  }

  /// Close all boxes
  Future<void> close() async {
    try {
      await Hive.close();
    } catch (e) {
      print('❌ Error closing Hive: $e');
    }
  }
}
