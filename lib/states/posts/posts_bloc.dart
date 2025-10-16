import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService _apiService;

  PostsBloc({ApiService? apiService})
    : _apiService = apiService ?? ApiService(),
      super(const PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(const PostsLoading());
    try {
      final posts = await _apiService.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<PostsState> emit,
  ) async {
    // Keep the current state while refreshing
    try {
      final posts = await _apiService.getPosts();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
