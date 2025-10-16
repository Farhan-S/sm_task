import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPosts extends PostsEvent {
  const FetchPosts();
}

class RefreshPosts extends PostsEvent {
  const RefreshPosts();
}

class LoadCachedPosts extends PostsEvent {
  const LoadCachedPosts();
}
