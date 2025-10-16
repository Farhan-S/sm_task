import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';
import '../../services/local_database_service.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService _apiService;
  final LocalDatabaseService _localDb;

  PostsBloc({
    ApiService? apiService,
    LocalDatabaseService? localDatabaseService,
  })  : _apiService = apiService ?? ApiService(),
        _localDb = localDatabaseService ?? LocalDatabaseService(),
        super(const PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<LoadCachedPosts>(_onLoadCachedPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(const PostsLoading());
    
    try {
      // Try to fetch from API
      final posts = await _apiService.getPosts();
      
      // Cache the data
      await _localDb.cachePosts(posts);
      
      emit(PostsLoaded(posts, isFromCache: false));
    } catch (e) {
      // If API call fails, try to load from cache
      final hasCachedData = await _localDb.hasCachedData();
      
      if (hasCachedData) {
        final cachedPosts = await _localDb.getCachedPosts();
        final cacheTimestamp = await _localDb.getCacheTimestamp();
        
        if (cachedPosts.isNotEmpty) {
          emit(PostsLoadedFromCache(cachedPosts, cacheTimestamp: cacheTimestamp));
        } else {
          emit(PostsError(e.toString(), hasCachedData: false));
        }
      } else {
        emit(PostsError(e.toString(), hasCachedData: false));
      }
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostsState> emit,
  ) async {
    try {
      // Try to fetch fresh data from API
      final posts = await _apiService.getPosts();
      
      // Cache the new data
      await _localDb.cachePosts(posts);
      
      emit(PostsLoaded(posts, isFromCache: false));
    } catch (e) {
      // If refresh fails, load from cache if available
      final hasCachedData = await _localDb.hasCachedData();
      
      if (hasCachedData) {
        final cachedPosts = await _localDb.getCachedPosts();
        final cacheTimestamp = await _localDb.getCacheTimestamp();
        
        if (cachedPosts.isNotEmpty) {
          emit(PostsLoadedFromCache(cachedPosts, cacheTimestamp: cacheTimestamp));
        } else {
          emit(PostsError(e.toString(), hasCachedData: false));
        }
      } else {
        emit(PostsError(e.toString(), hasCachedData: false));
      }
    }
  }

  Future<void> _onLoadCachedPosts(
    LoadCachedPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(const PostsLoading());
    
    try {
      final hasCachedData = await _localDb.hasCachedData();
      
      if (hasCachedData) {
        final cachedPosts = await _localDb.getCachedPosts();
        final cacheTimestamp = await _localDb.getCacheTimestamp();
        
        if (cachedPosts.isNotEmpty) {
          emit(PostsLoadedFromCache(cachedPosts, cacheTimestamp: cacheTimestamp));
        } else {
          emit(const PostsError('No cached data available', hasCachedData: false));
        }
      } else {
        emit(const PostsError('No cached data available', hasCachedData: false));
      }
    } catch (e) {
      emit(PostsError('Error loading cached data: $e', hasCachedData: false));
    }
  }
}
