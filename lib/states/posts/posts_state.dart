import 'package:equatable/equatable.dart';

import '../../models/post.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final bool isFromCache;

  const PostsLoaded(this.posts, {this.isFromCache = false});

  @override
  List<Object?> get props => [posts, isFromCache];
}

class PostsLoadedFromCache extends PostsState {
  final List<Post> posts;
  final DateTime? cacheTimestamp;

  const PostsLoadedFromCache(this.posts, {this.cacheTimestamp});

  @override
  List<Object?> get props => [posts, cacheTimestamp];
}

class PostsError extends PostsState {
  final String message;
  final bool hasCachedData;

  const PostsError(this.message, {this.hasCachedData = false});

  @override
  List<Object?> get props => [message, hasCachedData];
}
